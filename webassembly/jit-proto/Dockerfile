FROM ubuntu:16.04 AS build
RUN apt update
RUN apt install -y llvm-6.0 clang-6.0 cmake git libz-dev
RUN git clone https://github.com/WebAssembly/wasm-jit-prototype.git
RUN mkdir wasm-jit-prototype/obj
WORKDIR /wasm-jit-prototype/obj
RUN cmake -DCMAKE_CXX_COMPILER=clang++-6.0 ..
RUN make
RUN make install

FROM ubuntu:16.04
COPY --from=build /usr/local /usr/local
