FROM ubuntu:18.04
MAINTAINER Cheng JIANG <alex_cj96@foxmail.com>

ARG APP_USER=alex_cj96
ARG RUST_TOOLCHAIN=stable-2020-04-23

ENV DEBIAN_FRONTEND noninteractive

RUN useradd ${APP_USER} --user-group --create-home --shell /bin/bash --groups sudo

RUN apt update --fix-missing -y && \
     apt install -y \
        openssh-client \
        libssl-dev \
        git \
        wget \
        curl \
        build-essential \
        xz-utils \
        pkg-config \
        cmake \
        unzip \
        sudo \
        && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN echo '%sudo   ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${APP_USER}
WORKDIR /home/${APP_USER}
RUN mkdir -p /home/${APP_USER}/src

RUN wget https://github.com/upx/upx/releases/download/v3.94/upx-3.94-amd64_linux.tar.xz \
    && sudo tar -xJf upx-3.94-amd64_linux.tar.xz \
    && sudo chmod u+x upx-3.94-amd64_linux/upx \
    && sudo mv upx-3.94-amd64_linux/upx /usr/local/bin

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    sh -s -- -y --default-toolchain ${RUST_TOOLCHAIN}

ENV PATH=/home/${APP_USER}/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /home/${APP_USER}/src
