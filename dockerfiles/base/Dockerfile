FROM docker.io/library/ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

ARG TZ=America/New_York
ENV TZ ${TZ}

RUN apt update -y \
  && apt install -y ca-certificates libssl-dev tzdata build-essential cmake

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
