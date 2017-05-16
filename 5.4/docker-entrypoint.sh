#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

chown elasticsearch:elasticsearch /usr/share/elasticsearch/data

gosu elasticsearch "${@}"
