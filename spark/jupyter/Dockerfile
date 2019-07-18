FROM python:3-alpine
RUN apk add --no-cache openjdk9-jre bash libzmq
RUN apk add --no-cache --virtual .build gcc libc-dev zeromq-dev && \
    pip install pyspark jupyter toree && \
    rm -rf /root/.cache/pip && \
    apk del .build
RUN jupyter toree install --interpreters=Scala
RUN mkdir /root/.jupyter
ADD jupyter_notebook_config.json /root/.jupyter/jupyter_notebook_config.json
EXPOSE 8888
ENV PYSPARK_PYTHON=python3
CMD jupyter notebook --ip 0.0.0.0 --allow-root
