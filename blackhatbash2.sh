#!/bin/bash
set -x

# All this script does is create a directory, create a file within the directory, and then list the contents of the directory.

mkdir mydirectory
touch mydirectory/myfile
ls -l mydirectory

set +x

[Jose] UNIX-02-SIN-B-Mar-Jul-2026 ✓ $ bash -x blackhatbash2.sh
+ set -x
+ mkdir mydirectory
+ touch mydirectory/myfile
+ ls -l mydirectory
total 0
-rw-rw-rw- 1 vscode vscode 0 Jun  1 13:34 myfile
+ set +x
