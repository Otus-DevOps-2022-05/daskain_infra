#!/bin/bash

echo 'apt-get update'
echo "$(apt-get update)"

#Install mongodb
echo 'apt-get install -y mongodb'
echo "$(apt-get install -y mongodb)"

#Run service mongodb
echo 'systemctl start mongodb'
echo "$(systemctl start mongodb)"

#Active autorun mongodb
echo 'systemctl enable mongodb'
echo "$(systemctl enable mongodb)"

#Get status mongodb
echo 'systemctl status mongodb'
echo "$(systemctl status mongodb)"
