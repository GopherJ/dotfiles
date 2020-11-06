FROM ubuntu:18.04
MAINTAINER Cheng JIANG <alex_cj96@foxmail.com>

ARG APP_USER=alex_cj96
ARG GO_VERSION=1.14.4

ENV DEBIAN_FRONTEND noninteractive

RUN useradd ${APP_USER} --user-group --create-home --shell /bin/bash --groups sudo

RUN apt update --fix-missing -y && \
    apt install -y \
        openssh-client \
        libssl-dev \
        git \
        wget \
        curl \
        xz-utils \
        sudo \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo '%sudo   ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${APP_USER}
WORKDIR /home/${APP_USER}
RUN mkdir -p /home/${APP_USER}/src

# Install goenv
RUN git clone https://github.com/syndbg/goenv.git ~/.goenv \
    && export GOENV_ROOT="$HOME/.goenv" \
    && export PATH="$GOROOT/bin:$GOPATH/bin:$GOENV_ROOT/bin:$PATH" \
    && eval "$(goenv init -)" \
    && goenv install $GO_VERSION

ENV GOENV_ROOT=/home/${APP_USER}/.goenv

# Install upx
RUN wget https://github.com/upx/upx/releases/download/v3.94/upx-3.94-amd64_linux.tar.xz \
    && tar -xJf upx-3.94-amd64_linux.tar.xz \
    && chmod u+x upx-3.94-amd64_linux/upx \
    && sudo mv upx-3.94-amd64_linux/upx /usr/local/bin

ENV PATH=$GOROOT/bin:$GOPATH/bin:$GOENV_ROOT/bin:$GOENV_ROOT/versions/$GO_VERSION/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN echo 'eval "$(goenv init -)"' >> "$HOME/.bashrc"

WORKDIR /home/${APP_USER}/src

ENTRYPOINT ["/bin/bash", "-c"]
