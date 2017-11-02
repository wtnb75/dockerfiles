#! /bin/sh
set -x

docker pull nginx:alpine
NGINX_VERSION=$(docker run --rm nginx:alpine nginx -v 2>&1 | cut -f2 -d/)
NGINX_DAV_EXT_VERSION=0.1.0

[ -f nginx-${NGINX_VERSION}.tar.gz ] || curl -LO http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
[ -f nginx-dav-ext-module-${NGINX_DAV_EXT_VERSION}.tar.gz ] || curl -L -o nginx-dav-ext-module-${NGINX_DAV_EXT_VERSION}.tar.gz https://codeload.github.com/arut/nginx-dav-ext-module/tar.gz/v${NGINX_DAV_EXT_VERSION}

build_arg="--build-arg NGINX_VERSION=${NGINX_VERSION} --build-arg NGINX_DAV_EXT_VERSION=${NGINX_DAV_EXT_VERSION}"
[ -n "${http_proxy}" ] && build_arg="${build_arg} --build-arg http_proxy=${http_proxy}"
[ -n "${https_proxy}" ] && build_arg="${build_arg} --build-arg http_proxy=${https_proxy}"
docker build ${build_arg} -t nginx-webdav .
