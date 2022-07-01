#!/bin/bash

#Update system
echo 'sudo apt update'
echo "$(sudo apt update)"

#Install git
echo 'sudo apt install git'
echo "$(sudo apt install git)"

#Moving to user folder
echo 'cd ~'
echo "$(cd ~)"

#Clone git repo
echo 'git clone -b monolith https://github.com/express42/reddit.git'
echo "$(git clone -b monolith https://github.com/express42/reddit.git)"

#Moving to repo folder
echo 'cd reddit; bundle install'
echo "$(cd reddit; bundle install)"

#Starting puma server
echo 'puma -d'
echo "$(puma -d)"

#Get status and port
echo 'ps aux | grep puma'
echo "$(ps aux | grep puma)"
