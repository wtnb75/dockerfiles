FROM nginx:alpine AS build-env
ARG NGINX_VERSION=1.13.7
ARG LIBRESSL_VERSION=2.6.3
RUN apk add --no-cache gcc libc-dev make pcre-dev zlib-dev linux-headers curl gnupg libxslt-dev gd-dev geoip-dev expat-dev
RUN mkdir /src
ADD nginx-${NGINX_VERSION}.tar.gz /src
ADD libressl-${LIBRESSL_VERSION}.tar.gz /src
WORKDIR /src/nginx-${NGINX_VERSION}
RUN ./configure $(nginx -V 2>&1 | grep arguments | cut -f2- -d:) \
  --with-openssl=../libressl-${LIBRESSL_VERSION}
RUN make -j$(getconf _NPROCESSORS_ONLN)
RUN make install

FROM nginx:alpine
COPY --from=build-env /usr/sbin/nginx /usr/sbin/nginx
