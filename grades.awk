# Jose
# Systems Engineering
# Task 6 - Student grades

BEGIN {
    FS=","
}

NR==1 {
    next
}

{
    earned[$1] += $4
    possible[$1] += $5
}

END {

    printf "%-10s %-10s %s\n", "Student", "Percent", "Grade"

    for (s in earned) {

        pct = (earned[s] / possible[s]) * 100

        if (pct >= 90)
            grade = "A"
        else if (pct >= 80)
            grade = "B"
        else if (pct >= 70)
            grade = "C"
        else if (pct >= 60)
            grade = "D"
        else
            grade = "E"

        printf "%-10s %8.2f %s\n", s, pct, grade
    }
}