FROM fiadliel/java8-jre
ENV LD_LIBRARY_PATH /lib:/lib64:/opt/calibre/lib
ENV PATH $PATH:/opt/calibre/bin
RUN echo 'http://dl-3.alpinelinux.org/alpine/edge/testing/' >> /etc/apk/repositories
RUN apk add --no-cache nodejs graphviz mesa-gl git font-ipa curl nodejs-npm ttf-dejavu jq
RUN npm install gitbook-cli -g && rm -rf /tmp/*
RUN gitbook fetch && rm -rf /tmp/*
RUN apk add --no-cache --virtual .build-deps python3 xz && \
    curl https://download.calibre-ebook.com/linux-installer.py | python3 -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)" && \
    apk del .build-deps && \
    rm -rf /tmp/*
