# Elasticsearch Docker Container Image

[![Build Status](https://github.com/wodby/elasticsearch/workflows/Build%20docker%20image/badge.svg)](https://github.com/wodby/elasticsearch/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/elasticsearch.svg)](https://hub.docker.com/r/wodby/elasticsearch)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/elasticsearch.svg)](https://hub.docker.com/r/wodby/elasticsearch)

## Docker Images

❗For better reliability we release images with stability tags (`wodby/elasticsearch:7-X.X.X`) which correspond to [git tags](https://github.com/wodby/elasticsearch/releases). We strongly recommend using images only with stability tags. 

Overview:

- All images based on Alpine Linux
- Base image: [wodby/openjdk](https://github.com/wodby/openjdk)
- [GitHub actions builds](https://github.com/wodby/elasticsearch/actions)
- [Docker Hub](https://hub.docker.com/r/wodby/elasticsearch)

Supported tags and respective `Dockerfile` links:

- `7.17-alpine3.15`, `7-alpine3.15`, `alpine3.15`, `latest` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)
- `6.8-alpine3.15`, `6-alpine3.15`, `6.8`, `6` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)
- `7.17-alpine3.13`, `7-alpine3.13`, `alpine3.13` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)
- `6.8-alpine3.13`, `6-alpine3.13` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)

## Environment Variables

| Variable                                      | Default Value           | Description                                    |
|-----------------------------------------------|-------------------------|------------------------------------------------|
| `ES_BOOTSTRAP_MEMORY_LOCK`                    | `true`                  |                                                |
| `ES_CLUSTER_NAME`                             | `elasticsearch-default` |                                                |
| `ES_DISCOVERY_ZEN_MINIMUM_MASTER_NODES`       | `1`                     | 6.x only                                       |
| `ES_HTTP_CORS_ALLOW_ORIGIN`                   | `*`                     |                                                |
| `ES_HTTP_CORS_ENABLED`                        | `true`                  |                                                |
| `ES_HTTP_ENABLED`                             | `true`                  | 6.x only                                       |
| `ES_JAVA_OPTS`                                | `-Xms1g -Xmx1g`         |                                                |
| `ES_NETWORK_HOST`                             | `0.0.0.0`               |                                                |
| `ES_NODE_DATA`                                | `true`                  |                                                |
| `ES_NODE_INGEST`                              | `true`                  |                                                |
| `ES_NODE_MASTER`                              | `true`                  |                                                |
| `ES_NODE_MAX_LOCAL_STORAGE_NODES`             | `1`                     |                                                |
| `ES_PLUGINS_INSTALL`                          |                         | Install specified plugins (separated by comma) |
| `ES_SHARD_ALLOCATION_AWARENESS_ATTR_FILEPATH` |                         |                                                |
| `ES_SHARD_ALLOCATION_AWARENESS_ATTR`          |                         |                                                |
| `ES_TRANSPORT_HOST`                           | `localhost`             |                                                |

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
