#! /bin/sh

for i in compose/*.yml ; do
  echo ${i}
  docker-compose -f docker-compose.yml -f ${i} pull
  docker-compose -f docker-compose.yml -f ${i} build
done
