# syntax=docker/dockerfile:1
FROM node:25-slim

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

RUN rm -f /etc/apt/apt.conf.d/docker-clean \
  && echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache

RUN npm install -g corepack --force \
  && corepack enable \
  && corepack prepare pnpm@latest --activate

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
  apt-get update && apt-get install -yqq \
  python3-pip libyaml-dev software-properties-common \
  git curl zip unzip jq wget make yamllint yq

RUN pnpm install -g ajv-cli

COPY ./common /opt/basics/common
