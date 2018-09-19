FROM ubuntu:16.04 AS build
RUN sed -i.bak 's,http://archive.ubuntu.com/ubuntu,http://ftp.iij.ad.jp/pub/linux/ubuntu/archive,g;' /etc/apt/sources.list
RUN apt update
RUN apt install -y llvm-6.0 clang-6.0 git libz-dev curl cmake make
#RUN curl -L https://cmake.org/files/v3.12/cmake-3.12.2-Linux-x86_64.tar.gz | tar xfz - -C /usr/local
#RUN ln -s /usr/local/cmake-*-Linux-x86_64/bin/* /usr/local/bin
#RUN ln -s /usr/local/cmake-*-Linux-x86_64/share/* /usr/local/share/
#RUN git clone https://github.com/WebAssembly/wasm-jit-prototype.git
RUN git clone https://github.com/WAVM/WAVM.git
RUN mkdir WAVM/obj
WORKDIR /WAVM/obj
# XXX!
RUN git checkout 015fee21dd3be8c61c54b10490b2bd0d552a85fb
RUN cmake -DCMAKE_CXX_COMPILER=clang++-6.0 -DCMAKE_C_COMPILER=clang-6.0 ..
RUN make
RUN make install

FROM ubuntu:16.04
COPY --from=build /usr/local /usr/local
