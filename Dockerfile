FROM debian:9 AS builder

# Install prerequistes
RUN apt-get update
RUN apt-get install -y  gcc-arm-linux-gnueabihf     \
                        g++-arm-linux-gnueabihf     \
                        make wget libexpat-dev      \
                        gcc g++ zip              

# Cleaning up to reduce image size
RUN apt-get autoremove -y
RUN apt-get clean -y
RUN apt-get autoclean -y

WORKDIR  /root
RUN mkdir tmp
WORKDIR  /root/tmp

COPY ./build-gdb.sh ./build-gdb.sh
RUN chmod +x ./build-gdb.sh

ENV GDB_VERSION "8.3"
ENV HOST "x86_64-linux-gnu"
ENV TARGET "arm-linux-gnueabihf"
ENV TARGET_TOOLCHAIN "arm-linux-gnueabihf-"

ENV OUTPUT "/root/gdb-cross.tar.gz"

RUN ./build-gdb.sh ${OUTPUT}


FROM alpine:latest  
WORKDIR /root/
COPY --from=builder /root/gdb-cross.tar.gz /root/gdb-cross.tar.gz
CMD cat /root/gdb-cross.tar.gz


