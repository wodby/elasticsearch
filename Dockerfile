FROM wodby/openjdk:8-0.2.0

ARG ES_VER

ENV ES_VER="${ES_VER}" \
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
    # Download and verify elasticsearch.
    cd /tmp; \
    es_url="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VER}.tar.gz"; \
    curl -o es.tar.gz -Lskj "${es_url}"; \
    curl -o es.tar.gz.asc -Lskj "${es_url}.asc"; \
    GPG_KEYS=46095ACC8548582C1A2699A9D27D666CD88E42B4 gpg-verify.sh /tmp/es.tar.gz.asc /tmp/es.tar.gz; \
    \
    mkdir -p /usr/share/elasticsearch/data /usr/share/elasticsearch/logs; \
    tar zxf es.tar.gz --strip-components=1 -C /usr/share/elasticsearch; \
    # Default plugins.
    elasticsearch-plugin install --batch ingest-user-agent; \
    elasticsearch-plugin install --batch ingest-geoip; \
    \
    chown -R elasticsearch:elasticsearch /usr/share/elasticsearch; \
    \
    # Clean up
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