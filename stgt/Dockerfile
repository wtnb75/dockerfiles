FROM centos:centos7 AS build
RUN yum -y install gcc make
RUN curl -LO https://github.com/fujita/tgt/archive/v${tgtver:-1.0.69}.tar.gz
RUN tar xfz v${tgtver:-1.0.69}.tar.gz
RUN make -C tgt-${tgtver:-1.0.69} install-programs install-scripts

FROM alpine
RUN mkdir /lib64
COPY --from=build /usr/sbin/tgtd /usr/sbin/tgtd
COPY --from=build /usr/sbin/tgtadm /usr/sbin/tgtadm
COPY --from=build /usr/sbin/tgtimg /usr/sbin/tgtimg
COPY --from=build /lib64/libpthread.so.0 /lib64/libpthread.so.0
COPY --from=build /lib64/libdl.so.2 /lib64/libdl.so.2
COPY --from=build /lib64/libc.so.6 /lib64/libc.so.6
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2
EXPOSE 3260
ENTRYPOINT ["tgtd","-f"]
