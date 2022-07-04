#!/bin/bash

#create new instance
echo 'Create instance with packer'
yc compute instance create \
  --name reddit-packer-app \
  --hostname reddit-packer-app \
  --memory=4 \
  --create-boot-disk image-id=fd8moq7edmbc3autvj36,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/skutcher
