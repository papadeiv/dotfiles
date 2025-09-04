#!/bin/bash
# Rename files 1.png, 2.png, ..., N.png

n=1
for f in $(ls *.png | sort -n); do
    mv -i "$f" "$(printf "%d.png" "$n")"
    n=$((n+1))
done

echo "Renamed files from 1.png to $((n-1)).png"
