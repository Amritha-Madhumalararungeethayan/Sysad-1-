awk -F "|" '
total[$2] += $3
END{
        for(username in total)
        printf "%d,%s\n" , total[username] ,username
}' logfile.txt
