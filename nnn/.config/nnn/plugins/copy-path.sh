#!/bin/bash


# check if the file is provided
if [ -z $1 ]; then
  pwd | pbcopy 
else 
  # if the file is provided, copy the path of the file
  echo "$(pwd)/$1" | pbcopy
fi
