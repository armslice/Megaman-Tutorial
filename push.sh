#!/bin/bash
#Argument 1 is commit comment
#ARG=""
#if [ "$@" -eq "" ]
#  then
#    $ARG="Committed "
#  else
#    $ARG=$1
#fi
git add .
git commit -m "$1 - "$(date +"%D")"  "$(date +"%T")
git push -u origin master