#!/bin/bash 

export host_ip=$(curl -s ifconfig.io)

sudo apt update -y 
sudo apt install curl -y 
curl -sfL https://get.k3s.io | --tls-san=$host_ip sh -
sudo chmod 644 /etc/rancher/k3s/k3s/yaml
export KUBECONFIG=/etc/rancher/k3s/k3s/yaml