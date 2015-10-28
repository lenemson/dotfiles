# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jibanez <jibanez@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/10/28 14:31:48 by jibanez           #+#    #+#              #
#    Updated: 2015/10/28 18:37:47 by jibanez          ###   ########.fr        #
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

# Gets the absolute path of the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname $0)" && pwd)"

# Creates oldrc directory to store saved config files
mkdir -p $DOTFILES_DIR/oldrc

# Prints to stdout and execute command
exe() { echo $YEL"$@"$NON ; "$@" ; }

# Saves .*rc file if exist
save() {
	if [ -f $@ ]; then
		mv $HOME/$@ $DOTFILES_DIR/oldrc/$@.$(date +"%Y-%m-%d_%H-%M-%S")
		echo "old $@ saved in $DOTFILES_DIR/oldrc/$@.$(date +"%Y-%m-%d_%H-%M-%S")"
	fi
}

#
echo $GRN"Doftfiles git repository path: $DOTFILES_DIR"$NON

# Git
echo "\n$BLU Git: $NON"
cd $HOME
# Symlinks git config files
save .gitconfig
exe ln -s $DOTFILES_DIR/.gitconfig .
save .gitignore_global
exe ln -s $DOTFILES_DIR/.gitignore_global .

# Vim
echo "\n$BLU Vim: $NON"
# Symlinks .vim directory
exe ln -s $DOTFILES_DIR/.vim .
# Install/Clone Vundle into .vim/bundle
exe git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Symlinks vimrc
save .vimrc
exe ln -s .vim/vimrc .vimrc
# Install vim plugin via Vundle
exe vim +PluginInstall +qall

# Ruby
echo "\n$BLU Ruby: $NON"
cd $HOME
# Symlinks gemrc
save .gemrc
exe ln -s $DOTFILES_DIR/.gemrc .
# Install rbenv
exe git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
# Install ruby-build (rbenv install)
exe git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
# Install ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
#exe rbenv install $RUBY_V
#exe rbenv global $RUBY_V

# End
echo $GRN"\n\nTo Do:\n"
echo "- Install solarized for iTerm2\n\t-> https://github.com/altercation/solarized"
echo "- Install ruby\n\t-> rbenv install 2.2.3 && rbenv global 2.2.3"
echo "- Install brew\n\t-> ruby -e \$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"$NON

# Zsh
echo "\n$BLU Zsh: $NON"
# Install oh my zsh if needed
if [ -d $HOME/.oh-my-zsh ]; then
	echo "Oh My Zsh already installed"
else
	echo "Installing Oh My Zsh"
	exe git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
# Symlinks zshrc
save .zshrc
exe ln -s $DOTFILES_DIR/.zshrc .
# Symlinks Oh My Zsh custom directory, save the current
cd .oh-my-zsh/
mv custom $DOTFILES_DIR/oldrc/custom.$(date +"%Y-%m-%d_%H-%M-%S")
exe ln -s $DOTFILES_DIR/.oh-my-zsh/custom .
cd $HOME
exec zsh
