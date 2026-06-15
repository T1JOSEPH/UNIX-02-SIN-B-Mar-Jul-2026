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

## Task 3

Command:
awk -F',' 'NR>1 && $3=="FINAL" {printf "%-10s %3d\n", $1, $4}' Lab03-data.csv

Result:
Jackson    169
Kenji      162
Shane      193
Noah       116
Lucia      200
Priya      159
Andrew     123
Diana      152
Maria      152
Eliza      141
Tomas      163
Sam        152
Ava        172
Chelsey    142

Explanation:
The condition $3=="FINAL" selects only FINAL submissions. printf is used to align the student name left in a 10-character field and the score right-aligned.

## Task 4

Command:
awk -F',' 'NR>1 && $4 < ($5*0.60) {c++} END {print c}' Lab03-data.csv

Result:
50

Explanation:
The script compares the score ($4) with 60% of the maximum score ($5). If the score is below that threshold, a counter is incremented. The END block prints the total number of failing submissions.

## Task 5

Command:
awk -f per_assignment.awk Lab03-data.csv

Result:
Name       Low   High  Average
H01        46    100   82.71
H02        55    100   77.57
...
Q07        12    20    15.36

Explanation:
The script uses associative arrays indexed by assignment name. It stores the minimum score, maximum score, total score, and count of submissions for each assignment. In the END block it prints the statistics and computes the average with two decimal places.
Script:
per_assignment.awk

## Task 6

Command:
awk -f grades.awk Lab03-data.csv

Result:
Student    Percent    Grade
Shane         93.12 A
Diana         62.08 D
Kenji         86.45 B
Priya         71.04 C
Noah          63.08 D
Sam           72.90 C
Maria         79.57 C
Jackson       78.64 C
Ava           81.43 B
Eliza         84.16 B
Andrew        73.69 C
Tomas         82.22 B
Lucia         89.53 B
Chelsey       62.65 D

Explanation:
The script uses two associative arrays indexed by student name. One array stores the total points earned and the other stores the total points possible. The percentage is calculated and an if/else chain assigns the corresponding letter grade.
Script:
grades.awk


## Task 7

Command:
./run.sh Lab03-data.csv

Result:
Student    Percent    Grade
Andrew        73.69 C
Ava           81.43 B
Chelsey       62.65 D
Diana         62.08 D
Eliza         84.16 B
Jackson       78.64 C
Kenji         86.45 B
Lucia         89.53 B
Maria         79.57 C
Noah          63.08 D
Priya         71.04 C
Sam           72.90 C
Shane         93.12 A
Tomas         82.22 B

Explanation:
The Bash script receives the filename as an argument, executes grades.awk on that file, removes the header from the awk output, sorts the student records alphabetically, and prints the header at the top.
Script:
run.sh

HISTORY
    1  ls
    2  find . -name "Lab03-data.csv"
    3  awk -F',' 'NR>1{c++} END{print c}' Lab03-data.csv
    4  touch answers.md
    5  ## Task 1
    6  Command:
    7  awk -F',' 'NR>1{c++} END{print c}' Lab03-data.csv
    8  Result:
    9  <numero>
   10  Explanation:
   11  NR>1 ignora la cabecera. Se incrementa un contador por cada registro y en END se imprime el total de entregas.
   12  awk -F',' 'NR>1{c++} END{print c}' Lab03-data.csv
   13  git add answers.md Lab03-data.csv
   14  git commit -m "task-1"
   15  git push origin codeberg
   16  awk -F',' 'NR>1{seen[$1]=1} END{print length(seen)}' Lab03-data.csv
   17  git add answers.md
   18  git commit -m "task-2"
   19  git push origin codeberg
   20  awk -F',' 'NR>1 && $3=="FINAL" {printf "%-10s %3d\n", $1, $4}' Lab03-data.csv
   21  git add answers.md
   22  git commit -m "task-3"
   23  git push origin codeberg
   24  awk -F',' 'NR>1 && $4 < ($5*0.60) {c++} END {print c}' Lab03-data.csv
   25  git add answers.md
   26  git commit -m "task-4"
   27  git push origin codeberg
   28  touch per_assignment.awk
   29  awk -f per_assignment.awk Lab03-data.csv
   30  git add answers.md per_assignment.awk
   31  git commit -m "task-5"
   32  git push origin codeberg
   33  touch grades.awk
   34  awk -f grades.awk Lab03-data.csv
   35  git add answers.md grades.awk
   36  git commit -m "task-6"
   37  git push origin codeberg
   38  touch run.sh
   39  chmod +x run.sh
   40  ./run.sh Lab03-data.csv
   41  git add answers.md run.sh
   42  git commit -m "task-7"
   43  git push origin codeberg
   44  git log --oneline
   45  ls
   46  history