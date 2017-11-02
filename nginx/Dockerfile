FROM nginx:alpine AS build-env
ARG NGINX_VERSION=1.13.6
ARG NGINX_DAV_EXT_VERSION=0.1.0
RUN apk add --no-cache gcc libc-dev make openssl-dev pcre-dev zlib-dev linux-headers curl gnupg libxslt-dev gd-dev geoip-dev expat-dev
RUN mkdir /src
#ADD http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz /src/nginx.tar.gz
#ADD https://codeload.github.com/arut/nginx-dav-ext-module/tar.gz/v${NGINX_DAV_EXT_VERSION} /src/nginx-dav-ext-module.tar.gz
#RUN tar xfz /src/nginx.tar.gz -C /src
#RUN tar xfz /src/nginx-dav-ext-module.tar.gz -C /src
ADD nginx-${NGINX_VERSION}.tar.gz /src
ADD nginx-dav-ext-module-${NGINX_DAV_EXT_VERSION}.tar.gz /src
WORKDIR /src/nginx-${NGINX_VERSION}
RUN ./configure $(nginx -V 2>&1 | grep arguments | cut -f2- -d:) \
 --add-dynamic-module=../nginx-dav-ext-module-${NGINX_DAV_EXT_VERSION}
RUN make -j$(getconf _NPROCESSORS_ONLN) modules
RUN mkdir -p /usr/lib/nginx/modules
RUN install -c -m755 objs/ngx_http_dav_ext_module.so /usr/lib/nginx/modules/

FROM nginx:alpine
RUN apk add --no-cache expat
COPY --from=build-env /usr/lib/nginx/modules/ngx_http_dav_ext_module.so /usr/lib/nginx/modules/ngx_http_dav_ext_module.so
