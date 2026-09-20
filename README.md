# Elasticsearch Docker Container Image

[![Build Status](https://github.com/wodby/elasticsearch/workflows/Build%20docker%20image/badge.svg)](https://github.com/wodby/elasticsearch/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/elasticsearch.svg)](https://hub.docker.com/r/wodby/elasticsearch)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/elasticsearch.svg)](https://hub.docker.com/r/wodby/elasticsearch)

## Docker Images

Use image revision tags such as `wodby/elasticsearch:7-rN` to select a Wodby image revision.
Major and minor tags use the repository release number. Full-version tags such as
`wodby/elasticsearch:7.17.29-r0` start at `r0` for each exact upstream version.
Every published versioned revision tag has a matching annotated Git tag pointing to its release commit.
Existing tags remain available after support for their major or minor version ends.
See [release tags](https://github.com/wodby/elasticsearch/tags) for available revisions and the [image revision policy](https://github.com/wodby/images#image-revisions) for upgrade guidance.
Existing SemVer image tags remain available.

Overview:

- All images based on Alpine Linux
- Base image: [wodby/openjdk](https://github.com/wodby/openjdk)
- [GitHub actions builds](https://github.com/wodby/elasticsearch/actions)
- [Docker Hub](https://hub.docker.com/r/wodby/elasticsearch)

Supported tags and respective `Dockerfile` links:

- `7.17`, `7`, `latest` [_(Dockerfile)_](https://github.com/wodby/elasticsearch/tree/master/Dockerfile)

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

Deploy Elasticsearch with Kibana to your own server
via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com/stacks/elasticsearch).
