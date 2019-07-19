FROM python:3-alpine

ARG SPARK_VERSION=2.4.3
ARG HADOOP_VERSION=3.2.0
ARG baseurl=http://ftp.iij.ad.jp/pub/network/apache/

RUN apk --no-cache add openjdk8-jre curl bash libzmq ncurses

# install spark
RUN curl -sL ${baseurl}spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-without-hadoop.tgz | tar xfz - && \
    mv spark-${SPARK_VERSION}-bin-without-hadoop /spark

# install hadoop
RUN curl -sL ${baseurl}hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar xfz - && \
    mv hadoop-${HADOOP_VERSION} /hadoop

# install jupyter
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

ENV PYSPARK_PYTHON=python3
ENV SPARK_HOME=/spark
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
ENV HADOOP_HOME=/hadoop
ENV HADOOP_COMMON_LIB_NATIVE_DIR=/hadoop/lib/native
ENV PATH=${PATH}:/spark/bin:/hadoop/bin
ENV SPARK_DIST_CLASSPATH="/hadoop/etc/hadoop:/hadoop/share/hadoop/common/lib/*:/hadoop/share/hadoop/common/*:/hadoop/share/hadoop/hdfs:/hadoop/share/hadoop/hdfs/lib/*:/hadoop/share/hadoop/hdfs/*:/hadoop/share/hadoop/mapreduce/lib/*:/hadoop/share/hadoop/mapreduce/*:/hadoop/share/hadoop/yarn:/hadoop/share/hadoop/yarn/lib/*:/hadoop/share/hadoop/yarn/*:/hadoop/share/hadoop/tools/lib/*"

RUN jupyter toree install --spark_opts='--master=spark://master:7077' --interpreters=Scala,SQL
RUN mkdir /root/.jupyter

ADD start-namenode.sh /
ADD start-datanode.sh /
ADD core-site.xml /hadoop/etc/hadoop/
ADD hdfs-site.xml /hadoop/etc/hadoop/
ADD spark-defaults.conf /spark/conf/
