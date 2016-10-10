# Aliases
alias l='ls -l'
alias ll='ls -l'
alias la='ls -la'
alias ccd='cd ..'
alias g='git status'
alias gd='git branch'
alias 'tmuxat'='tmux a -t'

# Prompt
force_color_prompt=yes
export PS1="\[\033[38;5;6m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;6m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;166m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;6m\]λ\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

# Import other bashrc
RC=~/.bashrc_webedia
if [ -f $RC ]; then
  source $RC
  echo imported $RC
fi
