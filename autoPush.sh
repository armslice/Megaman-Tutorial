#!/bin/bash
#arg 1 is commit comment
ARG=""
if [ "$1" -eq  0 ]
  then
    $ARG="Committed"
  else
    $ARG=$1
fi
git add .
git commit -m $ARG" - "$(date +"%D")"  "$(date +"%T")
git push -u origin master