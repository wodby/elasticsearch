#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

if [[ "${ES_BOOTSTRAP_MEMORY_LOCK:-true}" == "true" ]]; then
    ulimit -l unlimited
fi

install_plugins() {
    if [[ -n "${ES_PLUGINS_INSTALL}" ]]; then
       orig_ifs=$IFS
       IFS=','
       for plugin in "${ES_PLUGINS_INSTALL}"; do
          if ! elasticsearch-plugin list | grep -qs ${plugin}; then
             yes | elasticsearch-plugin install --batch ${plugin}
          fi
       done
       IFS="${orig_ifs}"
    fi
}

process_templates() {
    # Get value for shard allocation awareness attributes.
    # https://www.elastic.co/guide/en/elasticsearch/reference/current/allocation-awareness.html#CO287-1
    if [[ -n "${ES_SHARD_ALLOCATION_AWARENESS_ATTR_FILEPATH}" && -n "${ES_SHARD_ALLOCATION_AWARENESS_ATTR}" ]]; then
        if [[ "${NODE_DATA:-true}" == "true" ]]; then
            export ES_SHARD_ATTR=$(cat "${ES_SHARD_ALLOCATION_AWARENESS_ATTR_FILEPATH}")
            export ES_NODE_NAME="${ES_SHARD_ATTR}-${ES_NODE_NAME}"
        fi
    fi

    gotpl /etc/gotpl/elasticsearch.yml.tmpl > /usr/share/elasticsearch/config/elasticsearch.yml
}

# The virtual file /proc/self/cgroup should list the current cgroup
# membership. For each hierarchy, you can follow the cgroup path from
# this file to the cgroup filesystem (usually /sys/fs/cgroup/) and
# introspect the statistics for the cgroup for the given
# hierarchy. Alas, Docker breaks this by mounting the container
# statistics at the root while leaving the cgroup paths as the actual
# paths. Therefore, Elasticsearch provides a mechanism to override
# reading the cgroup path from /proc/self/cgroup and instead uses the
# cgroup path defined the JVM system property
# es.cgroups.hierarchy.override. Therefore, we set this value here so
# that cgroup statistics are available for the container this process
# will run in.
export ES_JAVA_OPTS="-Des.cgroups.hierarchy.override=/ $ES_JAVA_OPTS"

# Generate random node name if not set.
if [[ -z "${ES_NODE_NAME}" ]]; then
	export ES_NODE_NAME=$(uuidgen)
fi

# Fix volume permissions.
chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data

install_plugins
process_templates

exec_init_scripts

if [[ "${1}" == 'make' ]]; then
    su-exec elasticsearch "${@}" -f /usr/local/bin/actions.mk
else
    su-exec elasticsearch "${@}"
fi
