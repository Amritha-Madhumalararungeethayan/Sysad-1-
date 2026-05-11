#!/usr/bin/env bash 

sudo groupadd -f  wardens
for user in $(yq -r '.wardens[].username ' roster.yaml)
do
sudo useradd -m -g  wardens "$user"
sudo useradd -m -d /home/wardens/$user "$user"
sudo mkdir -p /home/wardens/"$user"
echo " created $user"
done


