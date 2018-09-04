FROM nginx:alpine AS build-env
ARG NGINX_VERSION=1.15.3
ARG OPENSSL_VERSION=1.1.1-pre9
RUN apk add --no-cache gcc libc-dev make pcre-dev zlib-dev linux-headers curl gnupg libxslt-dev gd-dev geoip-dev expat-dev
RUN mkdir /src
#ADD http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz /src/nginx.tar.gz
#ADD https://codeload.github.com/arut/nginx-dav-ext-module/tar.gz/v${NGINX_DAV_EXT_VERSION} /src/nginx-dav-ext-module.tar.gz
#RUN tar xfz /src/nginx.tar.gz -C /src
#RUN tar xfz /src/nginx-dav-ext-module.tar.gz -C /src
ADD nginx-${NGINX_VERSION}.tar.gz /src
ADD openssl-${OPENSSL_VERSION}.tar.gz /src
WORKDIR /src/nginx-${NGINX_VERSION}
RUN ./configure $(nginx -V 2>&1 | grep arguments | cut -f2- -d:) \
 --with-openssl=../openssl-${OPENSSL_VERSION} --with-openssl-opt=enable-tls1_3
RUN make -j$(getconf _NPROCESSORS_ONLN)
RUN install -c -m755 objs/nginx /usr/sbin/nginx

FROM nginx:alpine
COPY --from=build-env /usr/sbin/nginx /usr/sbin/nginx
