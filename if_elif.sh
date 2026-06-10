#!/bin/bash
if [ -z "${USER_INPUT}" ]; then #Checks if USER_INPUT is empty.
echo "You must provide an argument!" #Prints an error message.
exit 1 #Stops the script with an error status.
fi #Ends the first if block.
if [ -f "${USER_INPUT}" ]; then #Checks if USER_INPUT is a file.
echo "${USER_INPUT} is a file." #Prints that USER_INPUT is a file.
elif [ -d "${USER_INPUT}" ]; then #Checks if USER_INPUT is a directory.
echo "${USER_INPUT} is a directory." #Prints that USER_INPUT is a directory.
else #If USER_INPUT is not a file or a directory.
echo "${USER_INPUT} is not a file or a directory." #Prints that USER_INPUT is not a file or a directory.    
fi #Ends the second if block.