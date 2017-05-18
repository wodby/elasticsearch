#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

chown elasticsearch:elasticsearch /usr/share/elasticsearch/data

if [[ "${1}" == 'make' ]]; then
    gosu elasticsearch "${@}" -f /usr/local/bin/actions.mk
else
    gosu elasticsearch "${@}"
fi
