#!/bin/bash
# All this script does is create a directory, create a file
# within the directory, and then list the contents of the di
set -x
rectory.
mkdir mydirectory
touch mydirectory/myfile
ls -l mydirectory
set +x

[Jose] UNIX-02-SIN-B-Mar-Jul-2026 ✓ $ bash -x blackhatbash2.sh
+ set -x
+ rectory.
blackhatbash2.sh: line 5: rectory.: command not found
+ mkdir mydirectory
+ touch mydirectory/myfile
+ ls -l mydirectory
total 0
-rw-rw-rw- 1 vscode vscode 0 Jun  1 13:27 myfile
+ set +x
