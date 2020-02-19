#!/bin/bash
git add .
git commit -m $1$(date +"%D___%T")
git push -u origin master
