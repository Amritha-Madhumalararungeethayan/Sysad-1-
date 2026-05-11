#!/usr/bin/env bash 

sudo groupadd -f bashers

for user in $(yq -r '.bashers[].username ' roster.yaml)
do
sudo useradd -m -g  bashers "$user"
sudo useradd -m -d /home/bashers/$user "$user"
sudo mkdir -p /home/bashers/"$user"/Drop_Zone
echo " created $user"
done



