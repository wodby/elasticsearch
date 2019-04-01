# Elasticsearch Docker Container Image

[![Build Status](https://travis-ci.org/wodby/elasticsearch.svg?branch=master)](https://travis-ci.org/wodby/elasticsearch)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/elasticsearch.svg)](https://hub.docker.com/r/wodby/elasticsearch)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/elasticsearch.svg)](https://hub.docker.com/r/wodby/elasticsearch)
[![Docker Layers](https://images.microbadger.com/badges/image/wodby/elasticsearch.svg)](https://microbadger.com/images/wodby/elasticsearch)

## Docker Images

❗For better reliability we release images with stability tags (`wodby/elasticsearch:6-X.X.X`) which correspond to [git tags](https://github.com/wodby/elasticsearch/releases). We strongly recommend using images only with stability tags. 

Overview:

* All images are based on Alpine Linux
* Base image: [wodby/openjdk](https://github.com/wodby/openjdk)
* [TravisCI builds](https://travis-ci.org/wodby/elasticsearch) 
* [Docker Hub](https://hub.docker.com/r/wodby/elasticsearch)

Supported tags and respective `Dockerfile` links:

* `6.7`, `6`, `latest` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)
* `5.6`, `5` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)

## Environment Variables

| Variable                                      | Default Value           | Description |
| --------------------------------------------- | ----------------------- | ----------- |
| `ES_JAVA_OPTS`                                | `-Xms1g -Xmx1g`         |             |
| `ES_CLUSTER_NAME`                             | `elasticsearch-default` |             |
| `ES_NODE_MASTER`                              | `true`                  |             |
| `ES_NODE_DATA`                                | `true`                  |             |
| `ES_NODE_INGEST`                              | `true`                  |             |
| `ES_HTTP_ENABLED`                             | `true`                  |             |
| `ES_NETWORK_HOST`                             | `0.0.0.0`               |             |
| `ES_HTTP_CORS_ENABLED`                        | `true`                  |             |
| `ES_HTTP_CORS_ALLOW_ORIGIN`                   | `*`                     |             |
| `ES_DISCOVERY_ZEN_MINIMUM_MASTER_NODES`       | `1`                     |             |
| `ES_NODE_MAX_LOCAL_STORAGE_NODES`             | `1`                     |             |
| `ES_SHARD_ALLOCATION_AWARENESS_ATTR`          |                         |             |
| `ES_SHARD_ALLOCATION_AWARENESS_ATTR_FILEPATH` |                         |             |
| `ES_BOOTSTRAP_MEMORY_LOCK`                    | `true`                  |             |
| `ELASTIC_CONTAINER`                           | `true`                  |             |

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

Deploy Elasticsearch with Kibana to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com/stacks/elasticsearch).
