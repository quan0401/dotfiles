#!/bin/bash

# Check if a file is provided
if [ -z "$1" ]; then
  # No file is provided, open the current directory in nvim
  nvim "$(pwd)"
else 
  # If a file is provided, copy the absolute path to the clipboard and open it in nvim
  path="$(pwd)/$1"
  nvim "$path"
fi

