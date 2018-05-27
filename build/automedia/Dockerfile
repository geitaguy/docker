FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update \
 && apt-get -qqy install automedia \
 && apt-get -qqy autoremove \
 && apt-get -qqy clean \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 

CMD 
