#!/bin/bash


# Check if a file or directory is provided
if [ -z "$1" ]; then
  # No file is provided, open the current directory in a new tmux vertical pane with nvim
  nvim $(pwd)
else 
  # If a file is provided, copy the absolute path to the clipboard and open it in a new tmux vertical pane with nvim
  path="$(realpath "$1")"  # Get the absolute path
  dir="$(dirname "$path")"  # Get the directory of the file
  nvim "$(pwd)/$1"
fi

