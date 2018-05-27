FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && \
    apt-get -qqy upgrade && \
    apt-get -qqy install bind9 && \
    apt-get -qqy autoremove && \
    apt-get -qqy clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 53/udp

CMD named -g
