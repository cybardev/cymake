#!/bin/sh
# compile a single-file cython code into native binary

# check for dependencies
DEP_LIST="python3 cython gcc mpv youtube-dl"
for dep in DEP_LIST; do
	command -v "$dep" 1>/dev/null || { printf "$dep not found. Please install it.\n" ; exit 2; }
done

# check for residue files and remove them (doesn't work yet. I'll figure it out...)
[ -e "./$1" ] && rm "./$1"
[ -e "./$1.c" ] && rm "./$1.c"

# check format of existing source file
if [ -e "./$1.pyx" ]; then
    srcname="$1.pyx"
elif [ -e "./$1.py" ];then
    srcname="$1.py"
else
    echo "No source file with name '$1' found in current directory."
    exit 1
fi

# check the installed Python 3 version and format it for use
pyver=$(python3 -V | cut -d "." -f 1-2 | tr '[:upper:]' '[:lower:]' | sed 's/ //g')

# transpile Cython source code into C code
cython --embed -o "$1.c" "$srcname"

# comppile the generated C code to native binary executable
gcc -Os -I "/usr/include/$pyver/" "$1.c" -l "$pyver" -o "$1"

# remove generated C file
rm "./$1.c"
