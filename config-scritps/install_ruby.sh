#!/bin/bash

#Update system
echo 'sudo apt update'
echo "$(sudo apt update)"

#Install ruby
echo 'sudo apt install -y ruby-full ruby-bundler build-essentiasudo'
echo "$(sudo apt install -y ruby-full ruby-bundler build-essential)"

#Get ruby status
echo 'ruby -v'
echo "$(ruby -v)"

#Get bundler status
echo 'bundler -v'
echo "$(bundler -v)"
