FROM ubuntu:latest
LABEL Cheng JIANG <alex_cj96@foxmail.com>

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
        libblas-dev \
        libopenblas-dev \
        liblapack-dev \
        zlib1g-dev \
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
RUN mkdir -p /home/${APP_USER}/dependencies

RUN wget https://cmake.org/files/v3.18/cmake-3.18.4.tar.gz \
    && tar -xzvf cmake-3.18.4.tar.gz \
    && cd cmake-3.18.4 \
    && ./bootstrap \
    && make -j4 \
    && sudo make install

WORKDIR /home/${APP_USER}/dependencies

RUN wget https://dl.bintray.com/boostorg/release/1.66.0/source/boost_1_66_0.tar.bz2 && \
    tar xjf boost_1_66_0.tar.bz2 && \
    cd boost_1_66_0 && \
    ./bootstrap.sh && \
    ./b2

RUN wget https://sourceforge.net/projects/geographiclib/files/distrib/GeographicLib-1.51.tar.gz && \
    tar xzf GeographicLib-1.51.tar.gz && \
    cd GeographicLib-1.51 && \
    mkdir build && \
    cd build && \
    cmake -D GEOGRAPHICLIB_LIB_TYPE=STATIC CMAKE_BUILD_TYPE=Release .. && \
    make && \
    make test && \
    sudo make install

RUN wget http://dlib.net/files/dlib-19.16.tar.bz2 && \
    tar xjf dlib-19.16.tar.bz2 &&\
    cd dlib-19.16 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    cmake --build . --config Release && \
    sudo make install

ENV BOOST_ROOT /home/${APP_USER}/dependencies/boost_1_66_0

WORKDIR /home/${APP_USER}/src
