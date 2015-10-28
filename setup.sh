#!/bin/sh

# Colors for output
GRN="\033[0;32m"
BLU="\033[0;34m"
RED="\033[0;31m"
YEL="\033[0;33m"
PUR="\033[1;35m"
NON="\033[0m"

# Gets the absolute path of the dotfiles directory
# Eg. ~/.dotfiles
DOTFILES_DIR="$(cd "$(dirname $0)" && pwd)"

# Creates an `oldrc` directory to store old config files/directories
# This directory will be ignored by git
mkdir -p $DOTFILES_DIR/oldrc/.oh-my-zsh

# Prints a title
title() { echo "\n"$BLU"$@:"$NON ; }

# Prints an information
info() { echo $PUR": $@"$NON ; }

# Prints a warning
warning() { echo $RED"warning: $@"$NON ; }

# Prints && executes a command
exe() { echo $YEL"> $@"$NON ; "$@" ; }

# Tries to git clone
trygit() { exe git clone $@ 2>/dev/null || warning "git repository already exists" ; }

# Saves a config (.*rc) file if already exists
savefile() {
	if [ -f $HOME/$@ ]; then # If file already exists
		mv $HOME/$@ $DOTFILES_DIR/oldrc/$@.$(date +"%Y-%m-%d_%H-%M-%S")
		info "old $@ saved in $DOTFILES_DIR/oldrc/$@.$(date +"%Y-%m-%d_%H-%M-%S")"
	fi
}

# Saves a config directory if already exists
savedir() {
	if [ -d $HOME/$@ ]; then # If directory already exists
		mv $HOME/$@ $DOTFILES_DIR/oldrc/$@.$(date +"%Y-%m-%d_%H-%M-%S")
		info "old $@ saved in $DOTFILES_DIR/oldrc/$@.$(date +"%Y-%m-%d_%H-%M-%S")"
	fi
}

# (-(-.(-.-).-)-)
echo $GRN"# Doftfiles git repository path: $DOTFILES_DIR"$NON

# Git
title "Git"
# Symlinks git config files
savefile .gitconfig
exe ln -s $DOTFILES_DIR/.gitconfig $HOME
savefile .gitignore_global
exe ln -s $DOTFILES_DIR/.gitignore_global $HOME
info "Git config done!"

# Vim
title "Vim"
# Symlinks .vim directory
savedir .vim
exe ln -s $DOTFILES_DIR/.vim $HOME
# Install/Clone Vundle into .vim/bundle
trygit https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
# Symlinks vimrc
savefile .vimrc
exe ln -s $HOME/.vim/vimrc $HOME/.vimrc
# Install vim plugin via Vundle
exe vim +PluginInstall +qall
info "Vim config done!"

# Ruby
title "Ruby"
# Symlinks gemrc
savefile .gemrc
exe ln -s $DOTFILES_DIR/.gemrc $HOME
# Install rbenv
trygit https://github.com/sstephenson/rbenv.git $HOME/.rbenv
# Install ruby-build (rbenv install enhancer)
trygit https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
info "Ruby config done!"

# Zsh
title "Zsh"
# Install/Clone oh my zsh
trygit https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
# Symlinks zshrc
savefile .zshrc
exe ln -s $DOTFILES_DIR/.zshrc $HOME
# Symlinks Oh My Zsh custom directory, save the current
savedir .oh-my-zsh/custom
exe ln -s $DOTFILES_DIR/.oh-my-zsh/custom $HOME/.oh-my-zsh
info "Zsh config done!"

# To Do
title "To Do"
echo "- Install solarized for iTerm2\n\t-> https://github.com/altercation/solarized"
echo "- Install ruby\n\t-> rbenv install 2.2.3 && rbenv global 2.2.3"
echo "- Install brew\n\t-> ruby -e \$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
cd $HOME
# Run a new zsh processus to load the new .zshrc
exec zsh
