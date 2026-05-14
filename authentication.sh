#!/usr/bin/env bash 

sudo groupadd -f bashers

yq -c -r '.roster.bashers[]' roster.yaml| while read -r line
do
	username=$(echo "$line" | yq -r .username)
	public_key=$(echo " $line" | yq -r .public_key)
	image_url=$(echo " $line" | yq -r .image_url)
	echo "$username"
        echo "$public_key"
	if ! id "$username" &>/dev/null
then
sudo useradd -m -d /home/bashers/$username -s /bin/bash -g bashers $username 2>/dev/null
	fi
sudo mkdir -p /home/bashers/$username/.ssh
sudo mkdir -p /home/bashers/$username/Drop_Zone
sudo chmod 700 /home/bashers/$username/.ssh

        echo "$public_key" | sudo tee /home/bashers/$username/.ssh/authorized_keys
sudo chmod 600 /home/bashers/$username/.ssh/authorized_keys
sudo passwd -l "$username"
grep -qxF "alias sus='ls'" /home/bashers/$username/.bashrc || \
        echo "alias sus='ls'" | sudo tee -a /home/bashers/$username/.bashrc /home/bashers/$username/.profile
grep -qxF "alias cap='clear'" /home/bashers/$username/.bashrc || \
        echo "alias cap='clear'" | sudo tee -a /home/bashers/$username/.bashrc /home/bashers/$username/.profile
grep -qxF "alias mog='tail'" /home/bashers/$username/.bashrc || \
        echo "alias mog='tail'" | sudo tee -a /home/bashers/$username/.bashrc /home/bashers/$username/.profile
        wget -O /tmp/${username}_avatar.jpg "$image_url"
sudo bash -c "jp2a /tmp/${username}_avatar.jpg > /home/bashers/$username/.avatar.txt"
sudo chown $username:bashers /home/bashers/$username/.avatar.txt
sudo chown -R $username:bashers /home/bashers/$username/.ssh
grep -qxF 'cat ~/.avatar.txt' /home/bashers/$username/.bashrc || \
echo 'cat ~/.avatar.txt' | sudo tee -a /home/bashers/$username/.bashrc
sudo setfacl -R -m g:guards:rx /home/bashers/$username
sudo setfacl -R -d -m g:guards:rx /home/bashers/$username
sudo chown -R $username:bashers /home/bashers/$username
rm -f /tmp/${username}_avatar.jpg
done
current_users=$(getent group bashers | cut -d: -f4 | tr ',' ' ')
yaml_users=$(yq -r '.roster.bashers[].username' roster.yaml)
for user in $current_users
do
    if ! echo "$yaml_users" | grep -qw "$user"
    then
        echo "Access revoked for $user"
        sudo passwd -l "$user"
        sudo usermod -L "$user"
        sudo gpasswd -d "$user" bashers
    fi
done
sudo systemctl restart ssh

