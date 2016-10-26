#!/bin/bash
msg="Update Blog Content"

if [ $# -eq 1 ]
  then msg="$1"
fi

git add -A && git commit -m "$msg" && git push origin master
rm -rf public/*
hugo
cd public/
git add -A && git commit -m "$msg" && git push origin master
cd ../