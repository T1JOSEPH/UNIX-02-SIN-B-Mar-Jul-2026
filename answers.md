## Task 1

Command:
awk -F',' 'NR>1{c++} END{print c}' Lab03-data.csv

Result:
322

Explanation:
NR>1 skips the header row. A counter is incremented for each submission and the END block prints the total number of submissions.
