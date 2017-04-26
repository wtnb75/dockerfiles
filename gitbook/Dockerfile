FROM frolvlad/alpine-glibc
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/calibre/lib
ENV PATH $PATH:/opt/calibre/bin
RUN apk add --no-cache openjdk8-jre nodejs graphviz mesa-gl
RUN npm install gitbook-cli -g
RUN gitbook fetch
RUN apk add --no-cache --virtual .build-deps python curl xz && \
    curl https://download.calibre-ebook.com/linux-installer.py | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)" && \
    apk del .build-deps && \
    rm -rf /tmp/calibre-installer-cache
