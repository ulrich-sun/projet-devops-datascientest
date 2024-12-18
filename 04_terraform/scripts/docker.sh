#!/bin/bash
sudo apt update 
sudo apt install -y curl 
curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh
sudo usermod -aG docker ubuntu
sudo service docker restart 