bash --version #Shows the installed Bash version on the system.
env #Displays all environment variables currently configured
echo ${SHELL} #Shows the current shell being used.
echo ${RANDOM} #Generates and displays a random number.
echo &{UID} #Tries to display the user ID, but this syntax is incorrect in Bash.
echo ${OSTYPE} #Displays the operating system type.
ps -e -f #Shows all running processes with detailed information.
ps -ef #Also displays all active processes in full format.
df --human-readable #Shows disk space usage in a readable format like MB or GB.
