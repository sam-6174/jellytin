#!/usr/bin/env bash
set -euo pipefail

# install docker
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker "$USER"  # assuming current $USER will run docker
exec sudo su -l "$USER"          # https://superuser.com/a/609141
docker run hello-world           # test the install
sudo systemctl enable docker     # start docker on boot

# install docker-compose
sudo apt-get install libffi-dev libssl-dev
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip
sudo pip3 install docker-compose
