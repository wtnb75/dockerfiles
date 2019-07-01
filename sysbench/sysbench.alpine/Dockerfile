FROM alpine AS build
RUN apk update
RUN apk add gcc automake autoconf libtool gcc make git mariadb-dev postgresql-dev libc-dev
RUN git clone --depth 1 https://github.com/akopytov/sysbench
RUN cd sysbench && \
    sh autogen.sh && \
    ./configure --with-mysql --with-pgsql && \
    make && \
    make install

FROM alioygur/wait-for:latest AS waitfor

FROM alpine
RUN apk add --no-cache mariadb-client mariadb-connector-c postgresql-client bash
COPY --from=build /usr/local/ /usr/local/
COPY --from=waitfor /app/wait-for /wait-for
