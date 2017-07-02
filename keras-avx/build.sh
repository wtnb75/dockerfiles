#! /bin/sh

export ver=1.2.1
curl -LO https://github.com/tensorflow/tensorflow/archive/v${ver}.tar.gz

for i in py{2,3}; do
  ( cd $i ; sh build.sh )
done
