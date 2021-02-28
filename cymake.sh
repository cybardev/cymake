#!/bin/sh
# compile a single-file cython code into native binary

# check for residue files and remove them (doesn't work yet. I'll figure it out...)
# [ test -e "./$1" ] && rm "./$1"
# [ test -e "./$1.c" ] && rm "./$1.c"

# check format of existing source file
# [ test -e "./$1.pyx" ] && srcname="$1.pyx" || [ test -e "./$1.py" ] && srcname="$1.py" || echo "No source file with name '$1' found in current directory." && exit 1

srcname="$1.pyx"

# check the installed Python 3 version and format it for use
pyver=$(python3 -V | cut -d "." -f 1-2 | tr '[:upper:]' '[:lower:]' | sed 's/ //g')

# transpile Cython source code into C code
cython --embed -o "$1.c" "$srcname"

# comppile the generated C code to native binary executable
gcc -Os -I "/usr/include/$pyver/" "$1.c" -l "$pyver" -o "$1"

# remove generated C file
rm "./$1.c"
