#!/bin/bash
#!/usr/bin/env bash

dist="$(. /etc/os-release && echo "$ID")"
output(){
    echo -e '\e[36m'"$1"'\e[0m';
}
warning(){
    echo -e '\e[31m'"$1"'\e[0m';
}

function trap_ctrlc ()
{
    output "Bye!"
    exit 2
}
trap "trap_ctrlc" 2


if [[ $EUID -ne 0 ]]; then
    output "Root is required to run the installer. Please type sudo su in your terminal."
    exit 1
fi

if ! [ -x "$(command -v curl)" ]; then
    output "cURL is required to run this script, please install it by using:"
    output "apt install curl"
    exit 1
fi

main(){
  output "Installing packages..."
  sleep 1s
  apt install -y python3 python3-pip git
  cd /etc
  mkdir listenssh
  cd listenssh
  git clone https://github.com/GhostSlayer/Listenssh .
  pip install -r requirements.txt
  mv config_example.ini config.ini
  output "Done! Installed in /etc/listenssh."
  exit 1
}

start(){
  output "Installation continuing in 5 seconds..."
  output 
  sleep 3s
  main
}

start
