#!/usr/bin/env bash 

sudo groupadd -f  wardens
for user in $(yq -r '.roster.wardens[].username ' roster.yaml)
do
sudo useradd -m -d /home/wardens/$user "$user" -g guards -s /bin/bash "$user"
sudo mkdir -p /home/wardens/"$user"
echo " created $user"
done


