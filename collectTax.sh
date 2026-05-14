#!/bin/bash
for user in /home/bashers/*
do 
size=$(du -s $user | awk '{print $1}')
echo "$size"
if [ $size -gt 5120 ]
then
    find "$user" -type f -printf "%T@|%p\n" | sort -n | head -3 |cut -d "|" -f2- |
     while IFS= read -r file 
    do 
bytes=$(stat -c %s "$file")
kb=$((bytes / 1024))

echo "$kb"
echo "$(date +"%Y-%m-%d %H:%M:%S") | $(stat -c %U "$file") | $kb | $(basename "$file")" >> logfile.txt
rm "$file"
chmod u=rw,g=,o= logfile.txt
sudo setfacl -m g:wardens:rw logfile.txt
sudo setfacl -m g:guards:rw logfile.txt
done
fi
done

