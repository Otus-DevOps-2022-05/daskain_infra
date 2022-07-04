#!/bin/bash

#Update system
echo 'apt update'
echo "$(apt update)"

#Install ruby
echo 'apt install -y ruby-full ruby-bundler build-essentiasudo'
echo "$(apt install -y ruby-full ruby-bundler build-essential)"

#Get ruby status
echo 'ruby -v'
echo "$(ruby -v)"

#Get bundler status
echo 'bundler -v'
