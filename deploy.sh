#!/bin/bash
msg="Update Blog Content"
if [ $# -eq 1 ]
  then msg="$1"
fi
git add * && git commit -m "$msg" && git push origin master
hugo
cd public/
git add * && git commit -m "$msg" && git push origin master
cd ../