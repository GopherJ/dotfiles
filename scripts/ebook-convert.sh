#!/bin/bash

for f in `find . -name '*.epub'`
do
  ebook-convert $f "${f%%.*}.pdf"
done

for f in `find . -name '*.mobi'`
do
  ebook-convert $f "${f%%.*}.pdf"
done

for f in `find . -name '*.azw3'`
do
  ebook-convert $f "${f%%.*}.pdf"
done
