#! /bin/sh

ver=${ver-1.2.1}
[ -f ../v${ver}.tar.gz ] && cp ../v${ver}.tar.gz ./
docker build --build-arg tfver=${ver} -t keras-avx:2 .
