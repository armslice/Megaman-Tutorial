#!/bin/bash
git add .
git commit -m "auto push"$(date +"%D-%H:%M:%S")
git push -u origin master
