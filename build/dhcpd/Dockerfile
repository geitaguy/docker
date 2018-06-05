FROM geitaguy/debian

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && \
    apt-get -qqy upgrade && \
    apt-get -qqy install isc-dhcp-server && \
    apt-get -qqy autoremove && \
    apt-get -qqy clean && \
    rm -rf /var/lib/apt/lists/*

ADD etc /etc

EXPOSE 67/udp
