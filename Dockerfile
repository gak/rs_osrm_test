# syntax=docker/dockerfile:experimental
FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive
RUN sed -i -e 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//mirror:\/\/mirrors\.ubuntu\.com\/mirrors\.txt/' /etc/apt/sources.list

RUN \
	--mount=type=cache,target=/var/lib/apt \
	apt-get update -y && \
	apt-get install -y curl build-essential libssl-dev zlib1g-dev libssl-dev pkg-config cmake \
	    libboost-iostreams-dev libboost-regex-dev libboost-date-time-dev libboost-filesystem-dev \
	    libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libexpat1-dev \
	    libbz2-dev lua5.2 liblua5.2-dev libtbb-dev \
	    gcc clang gdb valgrind git vim

RUN curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain nightly -y
ENV PATH /root/.cargo/bin:$PATH

RUN mkdir /build
WORKDIR /build
COPY * /build

RUN cargo build
