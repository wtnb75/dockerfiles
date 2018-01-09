FROM ruby:latest
ARG PJS_VER=2.1.1
RUN gem i selenium-webdriver --no-ri --no-rdoc
RUN curl -sL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PJS_VER}-linux-x86_64.tar.bz2 | tar xjf - -C /usr/local
RUN ln -sf /usr/local/phantomjs-${PJS_VER}-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
