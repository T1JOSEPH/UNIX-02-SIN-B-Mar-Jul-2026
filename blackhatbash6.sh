#!/bin/bash
ls -l / | grep "bin"
SCRIPT_NAME="${0}"
TARGET="${1}"
echo "Running the script ${SCRIPT_NAME}.."
echo "Pinging the target: ${TARGET}..."
ping "${TARGET}"
chmod u+x ping_with_arguments.sh
./ping_with_arguments.sh nostarch.com
echo "The arguments are: $@"
echo "The total number of arguments is: $#"
./bashhatbash6.sh "1" "2" "3"