FROM geitaguy/debian

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update \
 && apt-get -qqy install --no-install-recommends samba \
 && apt-get -qqy autoremove \
 && apt-get -qqy clean \
 && rm -rf /var/lib/apt/lists/*

ADD etc /etc

EXPOSE 137 138 139 445

VOLUME /var/lib/samba
