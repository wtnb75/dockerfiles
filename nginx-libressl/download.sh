#! /bin/sh

NGINX_VERSION=${NGINX_VERSION-1.13.7}
LIBRESSL_VERSION=${LIBRESSL_VERSION-2.6.3}

[ -f nginx-${NGINX_VERSION}.tar.gz ] || curl -LO http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
[ -f libressl-${LIBRESSL_VERSION}.tar.gz ] || curl -LO https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${LIBRESSL_VERSION}.tar.gz
