#!/bin/bash

> oldFiles.txt

files=`grep " jane " ~/data/list.txt | cut -d ' ' -f 3`

for line in $files; do
    if test -e ~/"$line"; then
        echo ~/"$line" >> oldFiles.txt
    fi
done
