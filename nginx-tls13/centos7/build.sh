#! /bin/sh
set -x

export no_proxy=$(docker-machine ip)

OPENSSL_VERSION=1.1.1-pre9

[ -f openssl-${OPENSSL_VERSION}.tar.gz ] || curl -LO https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz

build_arg="--build-arg OPENSSL_VERSION=${OPENSSL_VERSION}"
[ -n "${http_proxy}" ] && build_arg="${build_arg} --build-arg http_proxy=${http_proxy}"
[ -n "${https_proxy}" ] && build_arg="${build_arg} --build-arg http_proxy=${https_proxy}"
docker build ${build_arg} -t nginx-tls13:centos7 .
