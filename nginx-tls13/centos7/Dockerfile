FROM centos:centos7 AS build-env
ARG OPENSSL_VERSION=1.1.1-pre9
ADD nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum install -y rpm-build zlib-devel pcre-devel gcc make rpmdevtools
RUN yumdownloader --source nginx
RUN rpm -ivh nginx-*.src.rpm
ADD nginx.spec.patch /root/rpmbuild/SPECS/
WORKDIR /root/rpmbuild/SPECS
RUN patch -p0 < nginx.spec.patch
RUN sed -i -e 's,openssl_version .*$,openssl_version '${OPENSSL_VERSION}',g;' nginx.spec
#RUN spectool -g -R nginx.spec
COPY openssl-${OPENSSL_VERSION}.tar.gz /root/rpmbuild/SOURCES/
RUN rpmbuild -bb --undefine=_disable_source_fetch nginx.spec
RUN rpmbuild -bs nginx.spec

FROM centos:centos7
COPY --from=build-env /root/rpmbuild/RPMS/x86_64/* /
COPY --from=build-env /root/rpmbuild/SRPMS/* /
RUN yum localinstall -y /nginx-1*.x86_64.rpm && yum clean all
