FZF_PREFIX=$(brew --prefix)

# Setup fzf
# ---------
if [[ ! "$PATH" == *${FZF_PREFIX}/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${FZF_PREFIX}/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${FZF_PREFIX}/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${FZF_PREFIX}/opt/fzf/shell/key-bindings.zsh"
