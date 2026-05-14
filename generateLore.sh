#!/usr/bin/env bash 
while true 
do
x=$(shuf -n 1 slang.txt)
while read -r badword 
do
	stars=$(printf '%*s' "${#badword}" '' | tr ' ' '*')
x=$(echo "$x" | sed "s/$badword/$stars/g")
done <badwords.txt
echo "$x" | base64 > /opt/Bashrot_vault/$(date +%s).txt
sleep 30
done
