# Elasticsearch docker container image

[![Build Status](https://travis-ci.org/wodby/elasticsearch.svg?branch=master)](https://travis-ci.org/wodby/elasticsearch)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/elasticsearch.svg)](https://hub.docker.com/r/wodby/elasticsearch)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/elasticsearch.svg)](https://hub.docker.com/r/wodby/elasticsearch)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Supported tags and respective `Dockerfile` links:

- [`5.4`, `latest` (*5.4/Dockerfile*)](https://github.com/wodby/elasticsearch/tree/master/5.4/Dockerfile)

## Actions

Usage:
```
make COMMAND [params ...]

commands:
    check-ready [host max_try wait_seconds delay_seconds]
 
default params values:
    host localhost
    max_try 1
    wait_seconds 1
    delay_seconds 0
```

Examples:

```bash
# Wait for Elasticsearch to start
docker exec -ti [ID] make check-ready max_try=5 wait_seconds=10 delay_seconds=20 -f /usr/local/bin/actions.mk
```

## Using in production

Deploy Elasticsearch container to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com).
