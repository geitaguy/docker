FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && \
    apt-get -qqy upgrade && \
    apt-get -qqy install isc-dhcp-server && \
    apt-get -qqy autoremove && \
    apt-get -qqy clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 67/udp

CMD dhcpd -4 -f -d --no-pid -cf /etc/dhcp/dhcpd.conf -lf /var/lib/dhcp/dhcpd.leases
