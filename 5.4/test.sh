#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

name=$1
image=$2

docker run --name "${name}" "${image}"
#cid="$(docker run -d --name "${name}" "${image}")"
#trap "docker rm -vf $cid > /dev/null" EXIT
#
#elasticsearch() {
#	docker run --rm -i --link "${name}":"elasticsearch" "${image}" "${@}" host="elasticsearch"
#}
#
#elasticsearch make check-ready wait_seconds=10 max_try=12

