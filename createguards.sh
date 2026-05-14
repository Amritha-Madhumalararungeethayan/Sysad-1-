#!/usr/bin/env bash 

sudo groupadd -f guards 
for user in $(yq -r '.roster.guards[].username ' roster.yaml)
do
	if ! id "$user" &>/dev/null
	then 
sudo useradd -m -d /home/guards/$user -g guards -s /bin/bash "$user"
echo "created $user"
	fi
sudo mkdir -p /home/guards/"$user"
done


