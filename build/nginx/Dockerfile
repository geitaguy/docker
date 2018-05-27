FROM arm32v6/nginx:mainline
ENV DEBIAN_FRONTEND=noninteractive

ENV S6_VERSION "1.21.2.2"

RUN echo "$S6_VERSION"

RUN apt-get -q update \
 && apt-get install -qy --no-install-recommends \
    curl tar git ca-certificates \
 && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-armhf.tar.gz | tar -xzC / \
 && apt-get -qqy autoremove \
 && apt-get -qqy clean \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
