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
DOTFILES_DIR="$HOME/.dotfiles"

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

# If ~/dotfiles already exists, delete it and re git clone it
if [ -d $DOTFILES_DIR ]; then
	rm -rf $DOTFILES_DIR
fi
trygit https://github.com/lenemson/dotfiles $DOTFILES_DIR
# Creates an `oldrc` directory to store old config files/directories
# This directory will be ignored by git
mkdir -p $DOTFILES_DIR/oldrc/.oh-my-zsh
# (-(-.(-.-).-)-)
echo $GRN"# Dotfiles git repository path: $DOTFILES_DIR"$NON

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

# Bash
title "Bash"
# Symlinks zshrc
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
savefile .bashrc
exe ln -s $DOTFILES_DIR/.bashrc $HOME
info "Bash config done!"

# Tmux
title "Tmux"
# Symlink tmux.conf
savefile .tmux.conf
exe ln -s $DOTFILES_DIR/.tmux.conf $HOME
info "Tmux config done!"

# Create bin directory
mkdir -p $HOME/bin

# Copy probes into bin directory
cp -r $DOTFILES_DIR/probes $HOME/bin

# Copy pushover.sh to bin directory and make it executable
cp $DOTFILES_DIR/pushover.sh $HOME/bin/pushover
chmod u+x $HOME/bin/pushover

# Copy dotfiles.sh to bin directory and make it executable
cp $DOTFILES_DIR/dotfiles.sh $HOME/bin/dotfiles
chmod u+x $HOME/bin/dotfiles
info "\ndotfiles command has been placed in ~/bin, it can now be used to manage dotfiles"

cd $HOME
exec bash
