#!/bin/sh -e

dir="$HOME/.local/share/scheme/words"

first() { cut -d' ' -f1; }

mkdir -p "$dir"

for n in $(chicken-doc -c chicken | first)
do
  chicken-doc -c chicken "$n" | first | tee "$dir/chicken-$n"
done

for n in $(chicken-doc -c | first)
do
  [ "$n" = "chicken" ] || chicken-doc -c "$n" | first | tee "$dir/$n"
done
