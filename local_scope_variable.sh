#!/bin/bash
PUBLISHER="No Starch Press"
print_name(){
local name
name="Black Hat Bash"
echo "${name} by ${PUBLISHER}"
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