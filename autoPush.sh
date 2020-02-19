#!/bin/bash
git add .
git commit -m "auto push: "$(date +"%D___%T")
git push -u origin master
