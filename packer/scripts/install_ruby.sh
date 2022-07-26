#!/bin/bash

sleep 30s
#Update system
echo 'apt-get update'
echo "$(apt-get update)"

#Install git
echo 'apt install -y git'
echo "$(apt install -y git)"


#Install ruby
echo 'apt install -y ruby-full ruby-bundler build-essentiasudo'
echo "$(apt install -y ruby-full ruby-bundler build-essential)"

#Get ruby status
echo 'ruby -v'
echo "$(ruby -v)"

#Get bundler status
echo 'bundler -v'
