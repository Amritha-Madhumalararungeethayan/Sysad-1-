#!/usr/bin/env bash 

sudo groupadd -f guards 
for user in $(yq -r '.guards[].username ' roster.yaml)
do
sudo useradd -m -g  guards "$user"
sudo useradd -m -d /home/guards/$user "$user"
sudo mkdir -p /home/guards/"$user"
echo " created $user"
done


