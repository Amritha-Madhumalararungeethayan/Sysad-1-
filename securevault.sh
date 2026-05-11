 sudo mkdir -p setfacl /opt/Bashrot_vault
 sudo setfacl -m "g:wardens:rwx" /opt/Bashrot_vault
 sudo setfacl -m "g:guards:rwx" /opt/Bashrot_vault
 sudo setfacl -m "g:bashers:---" /opt/Bashrot_vault
 sudo mkdir -p /opt/Bashrot_vault/.hidden
 sudo setfacl -m "g:bashers:--x" /opt/Bashrot_vault/.hidden
