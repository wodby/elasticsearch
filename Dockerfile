FROM wodby/openjdk:8-0.1.0

ARG ES_VER

ENV ES_VER=${ES_VER} \
    ES_URL="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VER}.tar.gz" \
    ES_ASC_URL="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VER}.tar.gz.asc" \
    GPG_KEY="46095ACC8548582C1A2699A9D27D666CD88E42B4" \
    \
    ES_JAVA_OPTS="-Xms1g -Xmx1g" \
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
        sudo \
        util-linux; \
    \
    apk add --no-cache -t .es-build-deps gnupg openssl; \
    \
    # Download and verify elasticsearch.
    cd /tmp; \
    curl -o elasticsearch.tar.gz -Lskj "${ES_URL}"; \
    curl -o elasticsearch.tar.gz.asc -Lskj "${ES_ASC_URL}"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "${GPG_KEY}"; \
    gpg --batch --verify elasticsearch.tar.gz.asc elasticsearch.tar.gz; \
    rm -r "${GNUPGHOME}" elasticsearch.tar.gz.asc; \
    \
    # Unpack and install plugins.
    mkdir -p /usr/share/elasticsearch/data /usr/share/elasticsearch/logs; \
    tar zxf elasticsearch.tar.gz --strip-components=1 -C /usr/share/elasticsearch; \
    elasticsearch-plugin install --batch ingest-user-agent; \
    elasticsearch-plugin install --batch ingest-geoip; \
    \
    chown -R elasticsearch:elasticsearch /usr/share/elasticsearch; \
    \
    # Configure sudoers.
    echo 'elasticsearch ALL=(root) NOPASSWD: /usr/local/bin/fix-permissions.sh' > /etc/sudoers.d/elasticsearch; \
    \
    # Clean up
    apk del --purge .es-build-deps; \
    rm -rf /tmp/*; \
    rm -rf /var/cache/apk/*

USER 1000

WORKDIR /usr/share/elasticsearch

VOLUME /usr/share/elasticsearch/data

COPY templates /etc/gotpl/
COPY config /usr/share/elasticsearch/config/
COPY bin /usr/local/bin/

EXPOSE 9200 9300

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["elasticsearch"]