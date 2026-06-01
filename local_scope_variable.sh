#!/bin/bash
PUBLISHER="No Starch Press" Globalvariable #Works in the entire script. It can be used inside and outside functions.
print_name(){
local name        Localvariable #Works only inside the function where it was created. Outside the function, it cannot be accessed.
name="Black Hat Bash"
echo "${name} by ${PUBLISHER}"   Infoke Fuction #A function is a reusable block of commands in Bash. It helps organize code and avoid repeating commands.
}
print_name
echo "Variable ${name} will not be printed because it is a l
ocal variable."

#Resultados
[Jose] UNIX-02-SIN-B-Mar-Jul-2026 ✓ $ bash local_scope_variable.sh
Black Hat Bash by No Starch Press
Variable  will not be printed because it is a l
ocal variable.
[Jose] UNIX-02-SIN-B-Mar-Jul-2026 ✓ $ bash local_scope_variable.sh
Black Hat Bash by No Starch Press
Variable  will not be printed because it is a l
ocal variable.
[Jose] UNIX-02-SIN-B-Mar-Jul-2026 ✓ $ 

