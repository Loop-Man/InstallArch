# Setup fzf
# ---------
if [[ ! "$PATH" == */home/orion/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/orion/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/orion/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/orion/.fzf/shell/key-bindings.zsh"
