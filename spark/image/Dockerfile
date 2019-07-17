FROM alpine

ARG SPARK_VERSION=2.4.3
ARG HADOOP_VERSION=2.7
ARG baseurl=http://ftp.iij.ad.jp/pub/network/apache/

RUN apk --no-cache add openjdk9-jre python3 curl bash

RUN curl -sL ${baseurl}spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | tar xfz - && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /spark
ENV PATH=${PATH}:/spark/bin
ENV PYSPARK_PYTHON=python3
