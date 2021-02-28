#!/bin/sh
# compile a single-file cython code into native binary

# check for residue files and remove them
[[ test -f "./$1" ]] && rm "./$1"
[[ test -f "./$1.c" ]] && rm "./$1.c"

# check the installed Python 3 version and format it for use
pyver=$(python3 -V | cut -d "." -f 1-2 | tr '[:upper:]' '[:lower:]' | sed 's/ //g')

# transpile Cython source code into C code
cython --embed -o "$1.c" "$1.pyx"

# comppile the generated C code to native binary executable
gcc -Os -I "/usr/include/$pyver/" "$1.c" -l "$pyver" -o "$1"

# remove generated C file
rm "./$1.c"
