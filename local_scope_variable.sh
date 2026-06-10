#!/bin/bash
# Global variable - Works in the entire script. It can be used inside and outside functions.
PUBLISHER="No Starch Press"

# Function - A reusable block of commands in Bash. It helps organize code and avoid repeating commands.
print_name(){
  # Local variable - Works only inside the function where it was created. Outside the function, it cannot be accessed.
  local name
  name="Black Hat Bash"
  echo "${name} by ${PUBLISHER}"
}

print_name
echo "Variable ${name} will not be printed because it is a local variable."
[Jose] UNIX-02-SIN-B-Mar-Jul-2026 ✓ $ 

