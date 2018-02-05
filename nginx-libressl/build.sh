#! /bin/sh

export no_proxy=$(docker-machine ip)
args=""

for i in $(env | grep proxy | grep -v rvm | grep -v HTTP); do
  args="$args --build-arg $i"
done

libressl_tgz=$(curl -sL https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/ | cut -f2 -d\" | grep 'tar.gz$' | sort -r | head -n1 | cut -f2 -d-)
export LIBRESSL_VERSION=${libressl_tgz%.tar.gz}

nginx_tgz=$(curl -sL http://nginx.org/download/ | cut -f2 -d\" | grep 'tar.gz$' | gsort -Vr | head -n1 | cut -f2 -d-)
export NGINX_VERSION=${nginx_tgz%.tar.gz}

# sh download.sh

args="$args --build-arg NGINX_VERSION=${NGINX_VERSION} --build-arg LIBRESSL_VERSION=${LIBRESSL_VERSION}"
set -x
docker build -t $(basename $PWD) $args .
