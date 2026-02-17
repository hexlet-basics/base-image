FROM ubuntu:25.10

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yqq \
  python3-pip libyaml-dev software-properties-common

RUN apt-get install -yqq \
  git curl zip unzip jq wget make yamllint yq
RUN curl -sL https://deb.nodesource.com/setup_25.x | bash - && apt-get install -y nodejs
RUN npm install -g ajv-cli

COPY ./common /opt/basics/common
