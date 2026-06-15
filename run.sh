#!/bin/bash

file="$1"

echo "Student    Percent    Grade"

awk -f grades.awk "$file" | tail -n +2 | sort