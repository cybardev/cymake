#!/bin/sh

# compile a single-file cython code into native binary
cymake() {
    [[ test -f "./$1" ]] && rm "./$1"
    [[ test -f "./$1.c" ]] && rm "./$1.c"
    pyver=$(python3 -V | cut -d "." -f 1-2 | tr '[:upper:]' '[:lower:]' | sed 's/ //g')
    cython --embed -o "$1.c" "$1.pyx"
    gcc -Os -I "/usr/include/$pyver/" "$1.c" -l "$pyver" -o "$1"
    rm "./$1.c"
}
