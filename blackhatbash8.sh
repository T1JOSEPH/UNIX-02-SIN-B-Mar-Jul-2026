#!/bin/bash
awk '{print $1}' log.txt
awk '{print $1,$2,$3}' log.txt
awk '{print $1,$NF}' log.txt
awk '{print $NF}' log.txt
head log.txt
awk 'NR < 10' log.txt
grep "42.236.10.117" log.txt | awk '{print $7}'
sed 's/Mozilla/Godzilla/g' log.txt
sed 's/Mozilla/Godzilla/g' log.txt > newlog.txt
cat newlog.txt
grep 's/Mozilla/Godzilla/g' newlog.txt
sed 's/ //g' log.txt
sed 's/ //g' log.txt > newlog1.txt
grep Mozilla newlog1.txt
grep Godzilla newlog1.txt
sed '1d' log.txt
sed '$d' log.txt
sed '5,7d' log.txt
sed -n '2,15 p' log.txt
sed -i '1d' log.txt
sleep 100 & # Run sleep in the background
ps -ef | grep sleep # Check for the sleep process 
# Resultado
root           1       0  0 12:12 ?        00:00:00 /bin/sh -c echo Container started trap "exit 0" 15  exec "$@" while sleep 1 & wait $!; do :; done - #(1)
root       23505    1423  0 13:10 pts/0    00:00:00 sleep 100 #(2)
root       23735       1  0 13:10 ?        00:00:00 sleep 1  
root       23741    1423  0 13:10 pts/0    00:00:00 grep --color=auto sleep
jobs
#Resultado
[1]+  Running                 sleep 100 & # Background job 1
fg %1
#Resultado
sleep 100 # The sleep command is now running in the foreground
bg %1
#Resultado
[1]+  Running                 sleep 100 & # Background job 1    

