#!/bin/bash
for file in example_file*; do # Loop through files matching the pattern "example_file*"
if [[ "${file}" == "example_file1" ]]; then # Check if the current file is "example_file1"
echo "Skipping the first file" # Print a message indicating that the first file is being skipped
continue # Skip the rest of the loop for this iteration and move to the next file
fi #End of the if statement
echo "${RANDOM}" > "${file}" #Write a random number to the current file
done #End of the for loop