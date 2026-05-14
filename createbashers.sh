#!/usr/bin/env bash 

sudo groupadd -f bashers

for user in $(yq -r '.roster.bashers[].username ' roster.yaml)
do
if ! id "$user" &>/dev/null
then
sudo useradd -m -d /home/bashers/$user -g bashers -s /bin/bash "$user"
echo "created $user"
fi
sudo mkdir -p /home/bashers/"$user"/Drop_Zone
done



