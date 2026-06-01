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
bash -n script.sh #Checks the script for syntax errors without executing it. It is useful for debugging Bash scripts safely.
[Jose] UNIX-02-SIN-B-Mar-Jul-2026 # bash -n script.sh  
script.sh: line 3: unexpected EOF while looking for matching `"'
[Jose] UNIX-02-SIN-B-Mar-Jul-2026 # 
