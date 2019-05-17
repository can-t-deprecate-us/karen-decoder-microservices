#!/usr/bin/env bash

set -eux -o pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

# stop the services and clean up docker images
function clean() {
    set +e
    if [ -z "${prog_args}" ] || [ -n "${prog_args/*-d*/}" ]; then
        command docker-compose down
    fi
    command docker image prune -f
}

prog_args="${*:-}"
trap clean exit

"${RUN:-true}" || exit 0

if [ ${#} -gt 0 ]; then
    command docker-compose up "${@}"
else
    command docker-compose up
fi