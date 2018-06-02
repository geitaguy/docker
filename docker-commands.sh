dcroot="/var/docker"

builddir="${dcroot}/build"
datadir="${dcroot}/data"
configdir="${dcroot}/config"
runtimedir="${dcroot}/runtime"

dsmk() {
  service="$1"

  mkdir -p ${builddir}/${service}
  mkdir -p ${datadir}/${service}
  mkdir -p ${configdir}/${service}

  cat  >> ${configdir}/${service}/docker-compose.yml <<EOF
services:
  ${service}:
    build:
      context: ${builddir}/${service}
    env_file:
      - ${service}.env
    image: geitaguy/${service}
    network_mode: host
    volumes:
      - ${datadir}/${service}:/mnt/data:rw
version: '3.0'
EOF

  cat >> ${builddir}/${service}/Dockerfile <<EOF
FROM geitaguy/debian

RUN apt-get -qq update \\
 && apt-get -qqy install --no-install-recommends \\
    $service \\
 && apt-get -qqy autoremove \\
 && apt-get -qqy clean \\
 && rm -rf /var/lib/apt/lists/*

VOLUME

EXPOSE

EOF

  touch ${configdir}/${service}/${service}.env

  dsenv ${service}
  dscompose ${service}
}

cddata() {
  service="$1"
  cd ${datadir}/${service} || return 1
}

cdconfig() {
  service="$1"
  cd ${configdir}/${service} || return 1
}

cdbuild() {
  service="$1"
  cd ${builddir}/${service} || return 1
}

dsbuild() {
  service="$1"
  if [[ $service = "debian" && $(uname -m) = "armv6l" ]]; then
    dockerfile="Dockerfile-armhf"
  elif [[ $service = "debian" && $(uname -m) = "x86_64" ]]; then
    dockerfile="Dockerfile-amd64"
  elif [[ $service = "debian" ]]; then
    dockerfile="Dockerfile-$(uname -m)"
  else
    dockerfile="Dockerfile"
  fi

  echo "docker build --rm -t geitaguy/${service} -f ${builddir}/${service}/${dockerfile} ${builddir}/${service}"
  docker build --rm -t geitaguy/${service} -f ${builddir}/${service}/${dockerfile} ${builddir}/${service}
}

dsdeploy() {
  service="$1"
  shift 1
  args=$@
  docker stack deploy ${service} -c ${configdir}/${service}/docker-compose.yml
}

dscp() {
  service="$1"

  mkdir -p ${builddir}/${service}
  mkdir -p ${datadir}/${service}
  mkdir -p ${configdir}/${service}

  cp ${service}/Dockerfile ${builddir}/${service}/
  cp -r ${service}/source ${builddir}/${service}/

  cp ${service}/docker-compose.yml ${configdir}/${service}/
  cp ${service}/*.env ${configdir}/${service}/

  cp -r ${service}/config/* ${datadir}/${service}/
  cp -r ${service}/data/* ${datadir}/${service}/

}

dsComposefile(){
  service="$1"

  nano ${configdir}/${service}/docker-compose.yml
}

dsEnvfile(){
  service="$1"

  nano ${configdir}/${service}/${service}.env
}

dsDockerfile(){
  service="$1"

  nano ${builddir}/${service}/Dockerfile
}

dsprune(){
  docker container prune -f
  docker image prune -af
  docker volume prune -f
  docker network prune -f
}

mailsetup() {
  args=$@
  ${datadir}/mail/setup.sh -c ${datadir}/mail ${args}
}

dspull() {
git -C $dcroot pull origin master
}

dsbash() {
service="$1"
component="$2"

if [[ $component ]]; then
  container=$(docker ps | grep ${service}_${component} | cut -f 1 -d " ")
else
  container=$(docker ps | grep ${service} | cut -f 1 -d " ")
fi

echo "docker exec -it $container bash"
docker exec -it $container bash
}

dssed() {
  service="$1"
  commit="$2"

  sed -e "s;\:\ \.;\:\ ${builddir}/${service};g" \
  -e "s;./data;${datadir}/${service};g" \
  -e "s;./config;${datadir}/${service};g" \
  ${commit} ${configdir}/${service}/docker-compose.yml
  dcservice ${service} config
}
