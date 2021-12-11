FROM wodby/openjdk:11-jre-alpine

ARG ELASTICSEARCH_VER

ENV ELASTICSEARCH_VER="${ELASTICSEARCH_VER}" \
    ES_JAVA_OPTS="-Xms1g -Xmx1g" \
    ES_TMPDIR="/tmp" \
    \
    LANG="C.UTF-8" \
    \
    PATH="${PATH}:/usr/share/elasticsearch/bin"

RUN set -ex; \
    { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home; \
	chmod +x /usr/local/bin/docker-java-home; \
    \
    addgroup -g 1000 -S elasticsearch; \
    adduser -u 1000 -D -S -s /bin/bash -G elasticsearch elasticsearch; \
    echo "PS1='\w\$ '" >> /home/elasticsearch/.bashrc; \
    \
    apk add --update --no-cache -t .es-rundeps \
        bash \
        make \
        curl \
        su-exec \
        util-linux; \
    \
    apk add --no-cache -t .es-build-deps gnupg openssl git tar; \
    \
    gotpl_url="https://github.com/wodby/gotpl/releases/download/0.1.5/gotpl-alpine-linux-amd64-0.1.5.tar.gz"; \
    wget -qO- "${gotpl_url}" | tar xz -C /usr/local/bin; \
    git clone https://github.com/wodby/alpine /tmp/alpine; \
    cd /tmp/alpine; \
    latest=$(git describe --abbrev=0 --tags); \
    git checkout "${latest}"; \
    mv /tmp/alpine/bin/* /usr/local/bin; \
    \
    es_url="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VER}"; \
    [[ $(compare_semver "${ELASTICSEARCH_VER}" "7.0") == 0 ]] && es_url="${es_url}-linux-x86_64"; \
    es_url="${es_url}.tar.gz"; \
    \
    cd /tmp; \
    curl -o es.tar.gz -Lskj "${es_url}"; \
    curl -o es.tar.gz.asc -Lskj "${es_url}.asc"; \
    GPG_KEYS=46095ACC8548582C1A2699A9D27D666CD88E42B4 gpg_verify /tmp/es.tar.gz.asc /tmp/es.tar.gz; \
    \
    mkdir -p /usr/share/elasticsearch/data /usr/share/elasticsearch/logs; \
    # https://github.com/elastic/elasticsearch/issues/49417#issuecomment-557265783
    if tar tf es.tar.gz | head -n 1 | grep -q '^./$'; then \
        STRIP_COMPONENTS_COUNT=2; \
    else \
        STRIP_COMPONENTS_COUNT=1; \
    fi; \
    tar zxf es.tar.gz --strip-components=$STRIP_COMPONENTS_COUNT -C /usr/share/elasticsearch; \
    \
    chown -R elasticsearch:elasticsearch /usr/share/elasticsearch; \
    \
    apk del --purge .es-build-deps; \
    rm -rf /tmp/*; \
    rm -rf /var/cache/apk/*

# We have to use root as default user to update ulimit.
#USER 1000

WORKDIR /usr/share/elasticsearch

VOLUME /usr/share/elasticsearch/data

COPY templates /etc/gotpl/
COPY config /usr/share/elasticsearch/config/
COPY bin /usr/local/bin/

EXPOSE 9200 9300

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["elasticsearch"]