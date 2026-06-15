## Task 1

Command:
awk -F',' 'NR>1{c++} END{print c}' Lab03-data.csv

Result:
322

Explanation:
NR>1 skips the header row. A counter is incremented for each submission and the END block prints the total number of submissions.

## Task 2

Command:
awk -F',' 'NR>1{seen[$1]=1} END{print length(seen)}' Lab03-data.csv

Result:
14

Explanation:
An associative array named seen is used as a set. Each student name is stored once using seen[$1]=1, and the END block prints the number of unique students with length(seen).
