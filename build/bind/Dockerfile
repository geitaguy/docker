FROM geitaguy/debian

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update \
 && apt-get -qqy install --no-install-recommends bind9 \
 && apt-get -qqy autoremove \
 && apt-get -qqy clean \
 && rm -rf /var/lib/apt/lists/*

ADD etc /etc

EXPOSE 53/udp
