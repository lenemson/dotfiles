alias 'src'='source ~/.bashrc'

# Fs aliases
alias l='ls -l --group-directories-first'
alias lx='l -X'
alias la='l -a'
alias ccd='cd ..'

# Git aliases
alias g='git status'
alias gb='git branch'
alias gc='git checkout'
alias gd='git diff'

# Tmux aliases
alias 'ta'='tmux a -t'
alias 'at'='tmux a -t'

# Path
export PATH=~/.bin:$PATH

# Prompt
force_color_prompt=yes
export PS1="\[\033[38;5;6m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;6m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;166m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;6m\]λ\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

# Import other bashrc
RC=~/.bashrc_webedia
if [ -f $RC ]; then
  source $RC
  echo imported $RC
fi
