FROM ubuntu:latest
LABEL Cheng JIANG <alex_cj96@foxmail.com>

ARG APP_USER=alex_cj96

ENV DEBIAN_FRONTEND noninteractive

RUN useradd ${APP_USER} --user-group --create-home --shell /bin/bash --groups sudo

# libncurses5, libncursesw5, gawk, unzip, zlib1g-dev is required by openwrt build env
# subversion, mercurial are useful for some openwrt packages but not a must
RUN apt update --fix-missing \
    && apt install -y \
        libssl-dev \
        git \
        wget \
        curl \
        build-essential \
        libncurses5-dev \
        libncursesw5-dev \
        gawk \
        cmake \
        xz-utils \
        unzip \
        zlib1g-dev \
        subversion \
        mercurial \
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

RUN wget https://downloads.openwrt.org/releases/18.06.2/targets/ar71xx/generic/openwrt-sdk-18.06.2-ar71xx-generic_gcc-7.3.0_musl.Linux-x86_64.tar.xz \
    && tar xJf openwrt-sdk-18.06.2-ar71xx-generic_gcc-7.3.0_musl.Linux-x86_64.tar.xz \
    && cd openwrt-sdk-18.06.2-ar71xx-generic_gcc-7.3.0_musl.Linux-x86_64 \
    && scripts/feeds update \
    && scripts/feeds install libopenssl \
    && scripts/feeds install libpcap

COPY .config openwrt-sdk-18.06.2-ar71xx-generic_gcc-7.3.0_musl.Linux-x86_64/.config

RUN cd openwrt-sdk-18.06.2-ar71xx-generic_gcc-7.3.0_musl.Linux-x86_64 && make || true

ENV STAGING_DIR /home/${APP_USER}/openwrt-sdk-18.06.2-ar71xx-generic_gcc-7.3.0_musl.Linux-x86_64/staging_dir
ENV TARGET_DIR $STAGING_DIR/target-mips_24kc_musl
ENV TOOLCHAIN_DIR $STAGING_DIR/toolchain-mips_24kc_gcc-7.3.0_musl
ENV OPENSSL_LIB_DIR $TARGET_DIR/usr/lib
ENV OPENSSL_INCLUDE_DIR $TARGET_DIR/usr/include

WORKDIR /home/${APP_USER}/src
