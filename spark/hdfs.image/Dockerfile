FROM alpine
ARG baseurl=http://ftp.iij.ad.jp/pub/network/apache/hadoop/
ARG HADOOP_VERSION=3.2.0

RUN apk add --no-cache openjdk8-jre curl bash ncurses
RUN curl -s ${baseurl}core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar xfz -
#ADD hadoop-${HADOOP_VERSION}.tar.gz /
RUN mv hadoop-${HADOOP_VERSION} /hadoop
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
ENV PATH=${PATH}:/hadoop/bin
ENV HADOOP_HOME=/hadoop
ENV HADOOP_COMMON_LIB_NATIVE_DIR=/hadoop/lib/native

ADD start-namenode.sh /
ADD start-datanode.sh /
ADD core-site.xml /hadoop/etc/hadoop/
ADD hdfs-site.xml /hadoop/etc/hadoop/
