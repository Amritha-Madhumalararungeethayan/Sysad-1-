#!/bin/bash
for user in /home/bashers/*
do 
size=$(du -s $user | awk '{print $1}')
echo "$size"
if [ $size -gt 5120 ]
then
    find "$user" -type f -printf "%T@ %p\n" | sort -n | head -3 | awk '{$1=""; print}'|
    while read file 
    do 
bytes=$(stat -c %s "$file")
kb=$((bytes / 1024))

echo "$kb"
echo "$(date +"%Y-%m-%d %H:%M:%S") | $(stat -c %U "$file") | $kb | $(basename "$file")" >> logfile.txt
rm "$file"
done
fi
done
