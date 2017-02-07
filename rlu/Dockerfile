FROM centos:centos7
ADD 0001-mutex.patch /
RUN yum -y install git gcc make && \
    git clone https://github.com/rlu-sync/rlu.git && \
    cd rlu && \
    git apply /0001-mutex.patch && \
    make && \
    yum clean all
WORKDIR /rlu
