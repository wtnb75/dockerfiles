FROM rust
RUN git clone https://github.com/paritytech/wasmi.git --recursive
WORKDIR wasmi
RUN cargo build
RUN cargo install
