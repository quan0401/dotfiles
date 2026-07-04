# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh"
#
#
# #
# # Initialize Zsh completion
# autoload -Uz compinit
# compinit



# . "$HOME/.atuin/bin/env"
export PATH="/Applications/IntelliJ IDEA CE.app/Contents/MacOS:${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"
# # command prompt customize
# PS1='\W\$ '
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  # [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
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



# PS1=%'~ '

# This show the last 3 directories
# PROMPT='%3~ %# '
setopt prompt_subst
PROMPT='%F{green}$(echo ${PWD/#$HOME/~} | awk -F"/" "{print  \$(NF-3)\"/\"\$(NF-2)\"/\"\$(NF-1)\"/\"\$NF}")%f%# '

alias k="kubectl"


# this for changing the title of tab in iterm2
DISABLE_AUTO_TITLE="true"
# precmd() {
#   # sets the tab title to current dir
#   echo -ne "\e]1;${PWD##*/}\a"
#   # this is for title
#   printf "\e]2;$title\a"  # Window title
# }

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
alias nnn="nnn -deA"
export NNN_BMS="d:$HOME/Downloads;D:$HOME/dropbox/Document;c:$HOME/.config;q:$HOME/dropbox/Document/qode"
export NNN_USE_ICONS=1
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG='F:finder;o:fzopen;p:preview-tui;d:diffs;f:open-in-finder.sh;t:open-in-ghostty.sh;T:open-in-ghostty-tmux.sh;v:open-in-vscode.sh;V:imgview;y:copy-path.sh;e:open-with-nvim.sh;P:preview-tabbed;D:dragdrop;r:renamer;O:organize'
export NNN_TERMINAL="tmux"

# nnn in tmux with preview pane auto-started (-P p runs the preview-tui plugin at launch)
nnp() {
    if [ -n "$TMUX" ]; then
        nnn -deA -P p "$@"          # already in tmux -> just open with preview
    else
        tmux new-session "nnn -deA -P p"   # not in tmux -> spawn a tmux session running it
    fi
}

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
fpath=($fpath ~/.zsh/completion)export ANDROID_HOME=~/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH
export M2_HOME=/opt/maven
export PATH=$M2_HOME/bin:$PATH

export PATH="/usr/local/google-cloud-sdk/bin:$PATH"




# export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
# export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export JAVA_HOME="/opt/homebrew/opt/openjdk@21"

export PATH="$JAVA_HOME/bin:$PATH"

alias j17='export JAVA_HOME="/opt/homebrew/opt/openjdk@17" && export PATH="$JAVA_HOME/bin:$PATH"'
alias j21='export JAVA_HOME="/opt/homebrew/opt/openjdk@21" && export PATH="$JAVA_HOME/bin:$PATH"'



__conda_setup="$('/Users/quankento/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/quankento/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/quankento/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/quankento/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

export PATH="/Applications/Postgres.app/Contents/Versions/16/bin:$PATH"
export PG_CONFIG="/Applications/Postgres.app/Contents/Versions/16/bin/pg_config"

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh"

# export JAVA_HOME=$(/usr/libexec/java_home -v 25)
export PATH="$JAVA_HOME/bin:$PATH"





# bindkey -v

# # Faster ESC response
# export KEYTIMEOUT=1

# # Show mode in prompt
# function zle-keymap-select {
#   if [[ $KEYMAP == vicmd ]]; then
#     echo -ne '\e[1 q'   # block cursor
#   else
#     echo -ne '\e[5 q'   # beam cursor
#   fi
# }
# zle -N zle-keymap-select

# function zle-line-init {
#   echo -ne '\e[5 q'
# }
# zle -N zle-line-init




# Function to bridge Atuin and Warp
zatuin_run_selected() {
    local outfile="$(mktemp)"
    # Run atuin in interactive mode
    atuin search -i 2>"$outfile"
    local cmd=$(<"$outfile")
    rm -f "$outfile"
    if [[ -n "$cmd" ]]; then
        # Load the selected command into the Warp buffer
        print -z -- "$cmd"
    fi
}

# Alias it for convenience
alias hh='zatuin_run_selected'


# open INDEX.md (or given file) in Chrome via absolute path
# no arg: tries ./INDEX.md, then ./myDocs/INDEX.md
idx() {
  local f="$1"
  if [[ -z "$f" ]]; then
    if [[ -f "INDEX.md" ]]; then
      f="INDEX.md"
    elif [[ -f "myDocs/INDEX.md" ]]; then
      f="myDocs/INDEX.md"
    else
      echo "no INDEX.md in $(pwd) or $(pwd)/myDocs" >&2
      return 1
    fi
  elif [[ ! -f "$f" ]]; then
    echo "no $f in $(pwd)" >&2
    return 1
  fi
  local abs="$(cd "$(dirname "$f")" && pwd)/$(basename "$f")"
  open -a "Google Chrome" "file://$abs"
}
