#!/bin/bash

#Update system
echo 'sudo apt-get update'
echo "$(sudo apt-get update)"

#Install mongodb
echo 'sudo apt-get install -y mongodb'
echo "$(sudo apt-get install -y mongodb)"

#Run service mongodb
echo 'sudo systemctl start mongodb'
echo "$(sudo systemctl start mongodb)"

#Active autorun mongodb
echo 'sudo systemctl enable mongodb'
echo "$(sudo systemctl enable mongodb)"

#Get status mongodb
echo 'sudo systemctl status mongodb'
echo "$(sudo systemctl status mongodb)"
