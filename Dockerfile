ARG OPENJDK_VER

FROM wodby/openjdk:${OPENJDK_VER}-jre

ARG ELASTICSEARCH_VER

ENV ELASTICSEARCH_VER="${ELASTICSEARCH_VER}" \
    ES_JAVA_OPTS="-Xms1g -Xmx1g" \
    ES_TMPDIR="/tmp" \
    \
    PATH="/usr/share/elasticsearch/bin:${PATH}"

RUN set -ex; \
    \
    addgroup -g 1000 -S elasticsearch; \
    adduser -u 1000 -D -S -s /bin/bash -G elasticsearch elasticsearch; \
    echo "PS1='\w\$ '" >> /home/elasticsearch/.bashrc; \
    \
    apk add --update --no-cache -t .es-rundeps \
        make \
        su-exec \
        util-linux; \
    \
    apk add --no-cache -t .es-build-deps gnupg openssl; \
    \
    cd /tmp; \
    es_url="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-${ELASTICSEARCH_VER}.tar.gz"; \
    # Since 6.3 elasticsearch provides a separate OSS version without x-pack.
    [[ $(compare_semver "${ELASTICSEARCH_VER}" "6.3" "<") == 0 ]] && es_url="${es_url/-oss/}"; \
    curl -o es.tar.gz -Lskj "${es_url}"; \
    curl -o es.tar.gz.asc -Lskj "${es_url}.asc"; \
    GPG_KEYS=46095ACC8548582C1A2699A9D27D666CD88E42B4 gpg_verify /tmp/es.tar.gz.asc /tmp/es.tar.gz; \
    \
    mkdir -p /usr/share/elasticsearch/data /usr/share/elasticsearch/logs; \
    tar zxf es.tar.gz --strip-components=1 -C /usr/share/elasticsearch; \
    # Since 6.7 the following plugins converted to modules;
    if [[ $(compare_semver "${ELASTICSEARCH_VER}" "6.7" "<") == 0 ]]; then \
        # Default plugins.
        elasticsearch-plugin install --batch ingest-user-agent; \
        elasticsearch-plugin install --batch ingest-geoip; \
    fi; \
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