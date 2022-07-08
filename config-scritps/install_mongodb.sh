#!/bin/bash

#Get key
echo 'wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -'
echo "$(wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -)"
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodborg/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

#Update system
echo 'sudo apt-get update'
echo "$(sudo apt-get update)"

#Install mongodb
echo 'sudo apt-get install -y mongodb-org'
echo "$(sudo apt-get install -y mongodb-org)"

#Run service mongodb
echo 'sudo systemctl start mongod'
echo "$(sudo systemctl start mongod)"

#Active autorun mongodb
echo 'sudo systemctl enable mongod'
echo "$(sudo systemctl enable mongod)"

#Get status mongodb
echo 'sudo systemctl status mongod'
echo "$(sudo systemctl status mongod)"
