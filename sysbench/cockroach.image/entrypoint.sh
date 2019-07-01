#! /bin/sh

set -eu

if [ "${1-}" = "shell" ]; then
  shift
  exec /bin/sh "$@"
else
  /cockroach/cockroach.sh start --insecure &
  /wait-for-it.sh localhost:26257 -t 120
  if [ -n "${POSTGRES_DB}" ] ; then
    echo "CREATE DATABASE ${POSTGRES_DB};" | /cockroach/cockroach sql --insecure
  fi
  wait
fi
