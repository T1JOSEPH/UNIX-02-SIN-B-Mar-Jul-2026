#!/bin/bash
set -x

echo "This book's name is Linux"

set +x

$ echo "This book's name is ${book}"
This book's name is black hat bash

[Jose] UNIX-02-SIN-B-Mar-Jul-2026 ✓ $ bash -x blackhatbash3.sh
+ set -x
+ echo 'This book'\''s name is Linux'
This book's name is Linux
+ set +x

#resultados
$ root_directory=$(ls -ld /)
$ echo "${root_directory}"

[Jose] UNIX-02-SIN-B-Mar-Jul-2026 ✓ $ echo "${root_directory}"
drwxr-xr-x 1 root root 4096 Jun  1 12:27 /[Jose] UNIX-02-SIN-B-Mar-Jul-2026 ✓ 