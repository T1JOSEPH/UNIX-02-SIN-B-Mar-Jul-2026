#!/bin/bash -x 
#This line is called a shebang. It tells the system to run the script using Bash, and the -x option shows each command before it is executed for debugging purposes.
bash --version 
env 
echo ${SHELL} 
echo ${RANDOM} 
echo &{UID} 
echo ${OSTYPE} 
ps -e -f 
ps -ef
df --human-readable 
bash -r myscript.sh #Runs the script myscript.sh in restricted Bash mode

