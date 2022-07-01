#!/bin/bash
echo "deb http://repo.pritunl.com/stable/apt focal main" | sudo tee /etc/apt/sources.list.d/pritunl.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
curl https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc | sudo apt-key add -
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
apt install mongodb
apt update
apt -y install wireguard wireguard-tools
ufw disable
apt -y install pritunl mongodb
systemctl enable mongodb pritunl
systemctl start mongodb pritunl
