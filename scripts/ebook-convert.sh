#!/bin/bash

for f in `find . -name '*.epub' -o -name '*.mobi' -o -name '*.azw3'`
do
  ebook-convert $f "${f%%.*}.pdf"
  rm $f
done
