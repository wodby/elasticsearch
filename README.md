# Elasticsearch Docker Container Image

[![Build Status](https://travis-ci.org/wodby/elasticsearch.svg?branch=master)](https://travis-ci.org/wodby/elasticsearch)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/elasticsearch.svg)](https://hub.docker.com/r/wodby/elasticsearch)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/elasticsearch.svg)](https://hub.docker.com/r/wodby/elasticsearch)
[![Docker Layers](https://images.microbadger.com/badges/image/wodby/elasticsearch.svg)](https://microbadger.com/images/wodby/elasticsearch)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Docker Images

* All images are based on Alpine Linux
* Base image: [wodby/openjdk](https://github.com/wodby/openjdk)
* [TravisCI builds](https://travis-ci.org/wodby/elasticsearch) 
* [Docker Hub](https://hub.docker.com/r/wodby/elasticsearch)

Supported tags and respective `Dockerfile` links:

* `6`, `6.1`, `latest` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)
* `6.0` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)
* `5.6` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)
* `5.5` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)
* `5.4` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)

For better reliability we additionally release images with stability tags (`wodby/elasticsearch:6-X.X.X`) which correspond to [git tags](https://github.com/wodby/elasticsearch/releases). We **strongly recommend** using images only with stability tags. 

## Environment Variables

| Variable                          | Default Value           | Description |
| --------------------------------- | ----------------------- | ----------- |
| `ES_JAVA_OPTS`                    | `-Xms1g -Xmx1g`         |             |
| `CLUSTER_NAME`                    | `elasticsearch-default` |             |
| `NODE_MASTER`                     | `true`                  |             |
| `NODE_DATA`                       | `true`                  |             |
| `NODE_INGEST`                     | `true`                  |             |
| `HTTP_ENABLE`                     | `true`                  |             |
| `NETWORK_HOST`                    | `_site_`                |             |
| `HTTP_CORS_ENABLE`                | `true`                  |             |
| `HTTP_CORS_ALLOW_ORIGIN`          | `*`                     |             |
| `NUMBER_OF_MASTERS`               | `1`                     |             |
| `MAX_LOCAL_STORAGE_NODES`         | `1`                     |             |
| `SHARD_ALLOCATION_AWARENESS`      |                         |             |
| `SHARD_ALLOCATION_AWARENESS_ATTR` |                         |             |
| `MEMORY_LOCK`                     | `true`                  |             |
| `ELASTIC_CONTAINER`               | `true`                  |             |

## Orchestration Actions

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

## Deployment

Deploy Elasticsearch container to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com).
