FROM ubuntu:25.10

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yqq \
  git curl python3-pip libyaml-dev zip unzip jq software-properties-common wget
# RUN apt install python3-yamllint python3-yq
RUN apt-get install -y yamllint yq
RUN curl -sL https://deb.nodesource.com/setup_25.x | bash - && apt-get install -y nodejs
RUN npm install -g ajv-cli

COPY ./common /opt/basics/common
