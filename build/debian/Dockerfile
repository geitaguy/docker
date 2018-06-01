FROM debian:stretch-slim
ENV DEBIAN_FRONTEND=noninteractive

ENV S6_VERSION 1.21.2.2

RUN apt-get -q update \
 && apt-get install -qy --no-install-recommends \
    curl tar git ca-certificates nano less \
 && if [ $(uname -m) = "armv6l" ]; then \
      S6_ARCH="armhf" \
    else \
      S6_ARCH=$(uname -m) \
    fi \
 && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-$S6_ARCH.tar.gz | tar -xzC / \
 && apt-get -qqy autoremove \
 && apt-get -qqy clean \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
