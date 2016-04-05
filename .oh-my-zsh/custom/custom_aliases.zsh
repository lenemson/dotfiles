# Basic directory operations
alias ccd='cd ..'

# List direcory contents
alias l='ls -lh'
alias ll='ls -lh'
alias la='ls -lah'

# C/C++
alias 'gccc'='gcc -Wall -Wextra -Werror'
alias 'g+++'='g++ -Wall -Wextra -Werror'
alias 'w+'='clang++ -Wall -Wextra -Werror'
alias 'ret'='echo $?'
alias 'norm'='norminette **/*.[hc]'

# Python
alias 'py'='python'

# Ruby/Rails
alias 'be'='bundle exec'
alias 'ber'='bundle exec rails'

# Souk
alias c='clear'

# LOVE lua
alias loverun='open -n -a love'

# Docker/Docker-Machine
alias 'dinit'='eval "$(docker-machine env default)"'
alias 'dm'='docker-machine'
alias 'dc'='docker-compose'
