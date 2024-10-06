#!/bin/bash

# Check if a file or directory is provided
if [ -z "$1" ]; then
  # No file is provided, open the current directory in a new tmux vertical pane with nvim
  # tmux split-window -h "nvim $(pwd)"  # -h creates a vertical split in tmux
  nvim $(pwd)  # Open the current directory in nvim
else 
  # If a file is provided, copy the absolute path to the clipboard and open it in a new tmux vertical pane with nvim
  path="$(realpath "$1")"  # Get the absolute path
  # tmux split-window -h "nvim $path"  # Open the file in a new tmux vertical pane
  nvim $path  # Open the file in nvim
fi

