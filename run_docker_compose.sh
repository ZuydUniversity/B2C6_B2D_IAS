#!/bin/bash

function docker_do_install {
  # https://docs.docker.com/engine/install/debian/

  # Add Docker's official GPG key:
  sudo apt-get update -y
  sudo apt-get install ca-certificates curl -y
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # install docker packages
  sudo apt-get update -y
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
}

function docker_install {
  docker

  # if docker not found (exit code 127), do install
  if [ $? -eq 127 ]; then
    echo "[*] installing docker"
    docker_do_install
    echo "[+] installed docker"
  else
    echo "[+] docker installation found"
  fi
}

# build & run containers in background
function docker_compose_run {
  echo "[*] starting/updating docker containers"
  
  sudo docker compose pull
  sudo docker compose up --build --detach --force-recreate
}

docker_install
docker_compose_run