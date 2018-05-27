FROM geitaguy/debian

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update \
 && apt-get -qy install --no-install-recommends \
    cups cups-pdf avahi-daemon printer-driver-gutenprint \
 && apt-get -qqy autoremove \
 && apt-get -qqy clean \
 && rm -rf /var/lib/apt/lists/* \
 && echo "image/urf urf string(0,UNIRAST<00>)" > /usr/share/cups/mime/airprint.types \
 && echo "image/urf application/pdf 100  pdftoraster" > /usr/share/cups/mime/airprint.convs

#RUN dpkg --add-architecture armhf \
# && curl -fsSLO http://download.brother.com/welcome/dlf103361/brgenprintml2pdrv-4.0.0-1.armhf.deb \
# && dpkg -i brgenprintml2pdrv-4.0.0-1.armhf.deb \
# && rm brgenprintml2pdrv-4.0.0-1.armhf.deb

RUN apt-get -q update \
 && apt-get -qy install --no-install-recommends \
    qemu binfmt-support qemu-user-static \
 && update-binfmts --display \
 && dpkg --add-architecture i386 \
 && apt-get -q update \
 && apt-get -qy install --no-install-recommends \
    libc6:i386  \
 && apt-get -qqy autoremove \
 && apt-get -qqy clean \
 && rm -rf /var/lib/apt/lists/* \

EXPOSE 631 5353

ADD etc /etc

