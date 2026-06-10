#!/bin/bash
# This function checks if the current user ID equals zero.
check_if_root(){ # This is the function definition. The function is named check_if_root.
if [ "${EUID}" -eq "0" ]; then # This is the function body. It checks if the effective user ID (EUID) is equal to zero, which indicates that the user is root.
return 0 # If the condition is true, the function returns 0, which is a success status in bash.
else #If the condition is false, meaning the user is not root,
return 1 # the function returns 1, which is a failure status in bash.
fi # Ends the if statement.
} # Ends the function definition.
if check_if_root; then # This line calls the check_if_root function. If the function returns 0 (true), it executes the then block; otherwise, it executes the else block.
echo "User is root!" # If the user is root, it prints "User is root!" to the terminal.
else # If the user is not root, it executes this block.
echo "User is not root!" # If the user is not root, it prints "User is not root!" to the terminal.
fi # Ends the if statement.