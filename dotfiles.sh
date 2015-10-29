#!/bin/sh

# Usage
usage() {
	echo "Usage: dotfiles.sh <command> [<args>]\n"
	echo "Available commands:"
	echo "  update"
	echo "    Git pull dotfiles, vundle, rbenv, ruby-build and oh-my-sh repositories"
	echo "    Run with one argument for update only one repository eg. dotfiles.sh update dotfiles"
	echo "  sync"
	echo "    Git add, commit and push the changes in the dotfiles repository"
	echo "    A commit text can be supplied as second argument eg. dotfiles.sh sync \"Update vimrc\""
}

update() {
	if [ $1 == "all" ]; then
		echo "dotfiles:"
		cd $HOME/.dotfiles && git pull
		echo "vundle:"
		cd $HOME/.vim/bundle/Vundle.vim && git pull
		echo "rbenv:"
		cd $HOME/.rbenv && git pull
		echo "ruby-build:"
		cd $HOME/.rbenv/plugins/ruby-build && git pull
		echo "oh-my-zsh:"
		cd $HOME/.oh-my-zsh && git pull
	elif [ $1 == "dotfiles" ]; then
		echo "dotfiles:"
		cd $HOME/.dotfiles && git pull
	elif [ $1 == "vundle" ]; then
		echo "vundle:"
		cd $HOME/.vim/bundle/Vundle.vim && git pull
	elif [ $1 == "rbenv" ]; then
		echo "rbenv:"
		cd $HOME/.rbenv && git pull
	elif [ $1 == "ruby-build" ]; then
		echo "ruby-build:"
		cd $HOME/.rbenv/plugins/ruby-build && git pull
	elif [ $1 == "oh-my-zsh" ]; then
		echo "oh-my-zsh:"
		cd $HOME/.oh-my-zsh && git pull
	else
		usage
	fi
}

sync() {
	#echo $1
	cd $HOME/.dotfiles
	git add -A
	git commit -m "$1"
	git push
}

if [ $# == 0 ]; then
	usage
elif [ $# == 1 ] && [ $1 == "update" ]; then
	update all
elif [ $# == 2 ] && [ $1 == "update" ]; then
	update $2
elif [ $# == 1 ] && [ $1 == "sync" ]; then
	sync "Update dotfiles"
elif [ $# == 2 ] && [ $1 == "sync" ]; then
	echo $2
	sync $2
else
	usage
fi
