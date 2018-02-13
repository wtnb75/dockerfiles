#! /bin/sh

export no_proxy=$(docker-machine ip)
args=""

for i in $(env | grep proxy | grep -v rvm | grep -v HTTP); do
  args="$args --build-arg $i"
done

set -x
docker build -t $(basename $PWD) $args .
