# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh"
#
#
# # Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zprofile.post.zsh"
#
# # Initialize Zsh completion
# autoload -Uz compinit
# compinit
#
#
# # command prompt customize
# PS1='\W\$ '
# export NVM_DIR="$HOME/.nvm"
#   [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#   # [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
#
# __conda_setup="$('/Users/quankento/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/quankento/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/quankento/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/quankento/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
#
# . "$HOME/.atuin/bin/env"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

PS1=%'~ '

# this for changing the title of tab in iterm2
DISABLE_AUTO_TITLE="true"
precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
  # this is for title
  printf "\e]2;$title\a"  # Window title
}

# Function to set iTerm2 window title based on tmux session
function set_window_title {
    if [[ -n "$TMUX" ]]; then
        local session_name=$(tmux display-message -p '#S')
        echo -ne "\033]0;${session_name}\007"
    fi
}

# For bash or zsh, hook the function into the prompt command
if [[ -n "$TMUX" ]]; then
    PROMPT_COMMAND="set_window_title; $PROMPT_COMMAND"
fi

# zprofile
alias nnn="nnn -de"
export NNN_BMS="d:~/Downloads;D:~/dropbox/Document;c:~/.config"
export NNN_USE_ICONS=1
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG='f:finder;o:fzopen;p:preview-tui;d:diffs;t:nmount;v:imgview;c:copy-path.sh;e:open-with-nvim.sh;t:preview-tabbed'
export NNN_TERMINAL="tmux"
