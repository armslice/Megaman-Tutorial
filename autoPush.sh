#!/bin/bash
git add .
git commit -m "auto push: "$(date +"%D_%H:%M:%S")
git push -u origin master
