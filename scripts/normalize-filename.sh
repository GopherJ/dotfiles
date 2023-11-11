#!/bin/bash

for f in `find . -name '*.pdf'`
do
  fname=`echo $f | tr -d '》'`
  fname=`echo $fname | tr -d '《'`
  fname=`echo $fname | tr '：' '_'`
  echo $fname
done
