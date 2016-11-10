alias 'src'='source ~/.bashrc'

# Fs aliases
alias l='ls -l'
alias ld='l --group-directories-first'
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
GITRC=~/.git-prompt.sh
source $GITRC
force_color_prompt=yes

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
#export PS1="\[\033[38;5;6m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;6m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;166m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;6m\]$(__git_ps1 "[%s]")\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\$ "
#export PS1='\u@\h [\w]$(__git_ps1 " [%s]")\$ '
export PS1='\[$(tput bold)\]\[\033[38;5;243m\]\u\[$(tput sgr0)\]\[\033[38;5;247m\]@\[$(tput sgr0)\]\[\033[38;5;253m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;172m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;30m\]$(__git_ps1 "[%s]")\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]'
# Import other bashrc
RC=~/.bashrc_webedia
if [ -f $RC ]; then
  source $RC
  echo imported $RC
fi
