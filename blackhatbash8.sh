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