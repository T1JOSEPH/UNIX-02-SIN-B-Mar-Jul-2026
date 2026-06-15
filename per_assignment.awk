# Jose
# Systems Engineering
# Task 5 - Per assignment statistics

BEGIN {
    FS=","
}

NR==1 {
    next
}

{
    ass=$3
    score=$4

    sum[ass]+=score
    count[ass]++

    if (!(ass in min) || score < min[ass])
        min[ass]=score

    if (!(ass in max) || score > max[ass])
        max[ass]=score
}

END {
    printf "%-10s %-5s %-5s %-8s\n", "Name", "Low", "High", "Average"

    for (a in sum)
        printf "%-10s %-5d %-5d %.2f\n", a, min[a], max[a], sum[a]/count[a]
}