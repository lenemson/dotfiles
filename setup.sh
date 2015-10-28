# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jibanez <jibanez@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/10/28 14:31:48 by jibanez           #+#    #+#              #
#    Updated: 2015/10/28 17:12:31 by jibanez          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# Color for stdout
GRN="\033[0;32m"
BLU="\033[0;34m"
RED="\033[0;31m"
YEL="\033[0;33m"
NON="\033[0m"

# Ruby version wanted
RUBY_V="2.2.3"

# Print to stdout and execute command
exe() { echo $YEL"$@"$NON ; "$@" ; }

# Gets the absolute path of the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname $0)" && pwd)"
echo $GRN"doftfiles git repository path: $DOTFILES_DIR"$NON

# Git
echo "\n$BLU Git: $NON"
cd $HOME
# Symlinks git config files
exe ln -s $DOTFILES_DIR/.gitconfig .
exe ln -s $DOTFILES_DIR/.gitignore_global .

# Zsh
echo "\n$BLU Zsh: $NON"
# Install oh my zsh if needed
if [ $ZSH == $HOME/.oh-my-zsh ]; then
	echo "Oh My Zsh already installed"
else
	echo "installing Oh My Zsh"
	exe sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
# Symlinks zshrc
exe ln -s $DOTFILES_DIR/.zshrc .
# Symlinks Oh My Zsh custom directory
cd .oh-my-zsh/
exe ln -s $DOTFILES_DIR/.oh-my-zsh/custom .

# Ruby
echo "\n$BLU Ruby: $NON"
cd $HOME
# Symlinks gemrc
exe ln -s $DOTFILES_DIR/.gemrc .
# Install rbenv
exe git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
# Install ruby-build (rbenv install)
exe git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
# Install ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
exe rbenv install $RUBY_V
exe rbenv global $RUBY_V

# Vim
echo "\n$BLU Vim: $NON"
# Symlinks .vim directory
exe ln -s $DOTFILES_DIR/.vim .
# Install/Clone Vundle into .vim/bundle
exe git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Symlinks vimrc
exe ln -s .vim/vimrc .vimrc
# Install vim plugin via Vundle
exe vim +PluginInstall +qall

# End
echo $GRN"\n\nTo Do:\n"
echo "- Install brew\n"
echo "- Install solarized for iTerm2\n\t-> https://github.com/altercation/solarized"$NON
