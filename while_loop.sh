#!/bin/bash
SIGNAL_TO_STOP_FILE="stoploop" # The name of the file that will signal the loop to stop 
while [ ! -f "${SIGNAL_TO_STOP_FILE}" ]; do # Check if the file does not exist
echo "The file ${SIGNAL_TO_STOP_FILE} does not yet exist..." # Inform the user that the file does not exist
echo "Checking again in 2 seconds..." # Inform the user that the script will check again in 2 seconds
sleep 2 # Wait for 2 seconds before checking again
done # End of the while loop
echo "File was found! Exiting..." # Inform the user that the file was found and the loop is exiting
#Resultado
File was found! Exiting...