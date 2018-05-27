FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update &&     apt-get -qqy upgrade &&     apt-get -qqy install traefik &&     apt-get -qqy autoremove &&     apt-get -qqy clean &&     rm -rf /var/lib/apt/lists/*

EXPOSE 80

CMD traefik
