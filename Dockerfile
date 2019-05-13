ARG BASE_IMAGE_TAG

FROM wodby/alpine:${BASE_IMAGE_TAG}

ARG ELASTICSEARCH_VER

ENV ELASTICSEARCH_VER="${ELASTICSEARCH_VER}" \
    ES_JAVA_OPTS="-Xms1g -Xmx1g" \
    ES_TMPDIR="/tmp" \
    \
    LANG="C.UTF-8" \
    JAVA_HOME="/usr/lib/jvm/java-1.8-openjdk/jre" \
    \
    PATH="${PATH}:/usr/share/elasticsearch/bin:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin"

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
        make \
        openjdk8-jre \
        su-exec \
        util-linux; \
    \
    apk add --no-cache -t .es-build-deps gnupg openssl; \
    \
    cd /tmp; \
    es_url="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-${ELASTICSEARCH_VER}.tar.gz"; \
    curl -o es.tar.gz -Lskj "${es_url}"; \
    curl -o es.tar.gz.asc -Lskj "${es_url}.asc"; \
    GPG_KEYS=46095ACC8548582C1A2699A9D27D666CD88E42B4 gpg_verify /tmp/es.tar.gz.asc /tmp/es.tar.gz; \
    \
    mkdir -p /usr/share/elasticsearch/data /usr/share/elasticsearch/logs; \
    tar zxf es.tar.gz --strip-components=1 -C /usr/share/elasticsearch; \
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