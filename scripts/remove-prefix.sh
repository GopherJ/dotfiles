#!/bin/bash

prefix1="./[异步图书]."
prefix2="./[图灵程序设计丛书]."
prefix3="./[图灵图书]."
prefix4="./[图灵计算机科学丛书]."
prefix5="./[图灵交互设计丛书]."
prefix6="./[图灵原创]."
for f in `ls ./*.pdf`
do
  fname="${f#"$prefix1"}"
  fname="${fname#"$prefix2"}"
  fname="${fname#"$prefix3"}"
  fname="${fname#"$prefix4"}"
  fname="${fname#"$prefix5"}"
  fname="${fname#"$prefix6"}"
  if [ "$f" != "$fname" ]; then
    echo $fname
    # mv $f $fname
  fi
done
