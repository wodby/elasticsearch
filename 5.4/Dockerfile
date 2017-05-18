FROM docker.elastic.co/elasticsearch/elasticsearch:5.4.0

USER root

RUN yum install -y make \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64.asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && rm -r /root/.gnupg/ \
    && chmod +x /usr/local/bin/gosu \
    && elasticsearch-plugin remove x-pack \
    && rm -rf /usr/share/elasticsearch/config/x-pack

COPY docker-entrypoint.sh /
COPY actions /usr/local/bin

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/bin/bash", "bin/es-docker"]