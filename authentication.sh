#!/usr/bin/env bash 

sudo groupadd -f bashers

yq -c -r '.roster.bashers[]' roster.yaml| while read -r line
do
	username=$(echo " $line" | yq -r .username)
	public_key=$(echo " $line" | yq -r .public_key)
	image_url=$(echo " $line" | yq -r .image_url)
	echo "$username"
        echo "$public_key"
sudo useradd -m -d /home/bashers/$username -s /bin/bash -G bashers $username 2>/dev/null
sudo mkdir -p /home/bashers/$username/.ssh
sudo mkdir -p /home/bashers/$username/Drop_Zone
sudo chmod 700 /home/bashers/$username/.ssh

        echo "$public_key" | sudo tee /home/bashers/$username/.ssh/authorized_keys
sudo chmod 600 /home/bashers/$username/.ssh/authorized_keys
sudo passwd -l "$username"
        echo "alias sus='ls'" | sudo tee -a /home/bashers/$username/.bashrc /home/bashers/$username/.profile
        echo "alias cap='clear'" | sudo tee -a /home/bashers/$username/.bashrc /home/bashers/$username/.profile
        echo "alias mog='tail'" | sudo tee -a /home/bashers/$username/.bashrc /home/bashers/$username/.profile
        wget -O /tmp/${username}_avatar.jpg "$image_url"
sudo bash -c "jp2a /tmp/${username}_avatar.jpg > /home/bashers/$username/.avatar.txt"
sudo chown $username:bashers /home/bashers/$username/.avatar.txt
sudo chown -R $username:bashers /home/bashers/$username
echo 'cat ~/.avatar.txt' | sudo tee -a /home/bashers/$username/.bashrc
done
