docker-install() {
    apt-get -q update
    apt-get -qy install --no-install-recommends apt-transport-https ca-certificates curl gnupg2 software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
    apt-get -q update
    apt-get -qy install docker-ce
    usermod -aG docker "$SUDO_USER"
    curl -fsSLO /etc/bash_completion.d/docker https://raw.githubusercontent.com/docker/cli/b75596e1e4d5295ac69b9934d1bd8aff691a0de8/contrib/completion/bash/docker
    curl -fsSLO /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m)
    chmod +x /usr/local/bin/docker-compose
    docker run hello-world
}

  if [ ! $UID = "0" ]; then
    echo "$0 must be run as root"
    echo "Usage: sudo $0"
    exit 1
  else
    docker-install
  fi
