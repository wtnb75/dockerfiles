FROM golang as dev
RUN go get github.com/go-interpreter/wagon/cmd/wasm-run
RUN go get github.com/go-interpreter/wagon/cmd/wasm-dump

FROM ubuntu:16.04
COPY --from=dev /go/bin/* /usr/local/bin/
