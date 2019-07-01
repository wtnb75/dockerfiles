FROM willwill/wait-for-it:latest AS waitfor

FROM centos:centos7
RUN yum install -y epel-release && \
    yum install -y sysbench mariadb postgresql which && \
    yum clean all
COPY --from=waitfor /wait-for-it.sh /wait-for-it.sh
