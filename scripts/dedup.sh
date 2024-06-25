#!/bin/bash
declare -A arr
shopt -s globstar

if (( $# == 0 )); then
  echo "Usage: $0 <dir>"
  exit
fi

for file in `find $1 -type f`; do
  [[ -f "$file" ]] || continue

  read cksm _ < <(md5sum "$file")
  if ((arr[$cksm]++)); then
    echo "rm $file"
    rm $file
  fi
done
