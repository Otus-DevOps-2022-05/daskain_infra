#!/bin/bash

# sed -i -e 's/\r$//' scriptname.sh

sudo mv -f /tmp/mongod.conf /etc/mongod.conf
sudo systemctl restart mongodb
