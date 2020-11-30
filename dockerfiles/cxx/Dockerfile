FROM ubuntu:18.04
MAINTAINER Cheng JIANG <alex_cj96@foxmail.com>

ARG APP_USER=alex_cj96

ENV DEBIAN_FRONTEND noninteractive

RUN useradd ${APP_USER} --user-group --create-home --shell /bin/bash --groups sudo

RUN apt update --fix-missing \
    && apt install -y \
        libssl-dev \
        git \
        wget \
        curl \
        build-essential \
        libncurses5-dev \
        libncursesw5-dev \
        debhelper \
        inotify-tools \
        xz-utils \
        gawk \
        unzip \
        zlib1g-dev \
        pkg-config \
        sudo \
        ninja-build \
        autoconf \
        libtool \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo '%sudo   ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${APP_USER}
WORKDIR /home/${APP_USER}
RUN mkdir -p /home/${APP_USER}/src

RUN wget https://cmake.org/files/v3.18/cmake-3.18.4.tar.gz \
    && tar -xzvf cmake-3.18.4.tar.gz \
    && cd cmake-3.18.4 \
    && ./bootstrap \
    && make -j4 \
    && sudo make install

WORKDIR /home/${APP_USER}/src
