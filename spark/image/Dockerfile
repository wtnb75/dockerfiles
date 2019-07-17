FROM python:3-alpine

ARG SPARK_VERSION=2.4.3
ARG HADOOP_VERSION=2.7
ARG baseurl=http://ftp.iij.ad.jp/pub/network/apache/

RUN apk --no-cache add openjdk8-jre curl bash libzmq

RUN curl -sL ${baseurl}spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | tar xfz - && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /spark
ENV PATH=${PATH}:/spark/bin
ENV PYSPARK_PYTHON=python3
ENV SPARK_HOME=/spark

RUN apk add --no-cache --virtual .build gcc libc-dev zeromq-dev && \
    cd /spark/python && \
    python setup.py sdist && \
    pip install dist/*.tar.gz && \
    rm -rf build dist && \
    cd / && \
    ln -sf /spark/jars/*.jar /usr/local/lib/python3.7/site-packages/pyspark/jars/ && \
    pip install jupyter toree && \
    rm -rf /root/.cache/pip && \
    apk del .build
RUN jupyter toree install --spark_opts='--master=spark://master:7077' --interpreters=Scala,SQL
RUN mkdir /root/.jupyter
