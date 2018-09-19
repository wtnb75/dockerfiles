FROM golang as dev
RUN go get github.com/go-interpreter/wagon/cmd/wasm-run
RUN go get github.com/go-interpreter/wagon/cmd/wasm-dump

FROM alpine
COPY --from=dev /go/bin/* /usr/local/bin/
