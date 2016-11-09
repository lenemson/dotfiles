#!/bin/sh

# Usage
usage() {
	echo "Usage: dotfiles <command> [<args>]\n"
	echo "Available commands:"
	echo "  pull"
	echo "    Git pull dotfiles"
	echo "  push"
	echo "    Git add, commit and push the changes in the dotfiles repository"
	echo "    A commit text can be supplied as second argument eg. dotfiles.sh sync \"Update vimrc\""
}

pull() {
  cd $HOME/.dotfiles && git pull
}

push() {
	cd $HOME/.dotfiles
	git add -A
	git commit -m "$1"
	git push
}

if [ $# == 0 ]; then
	usage
elif [ $# == 1 ] && [ $1 == "pull" ]; then
	update
elif [ $# == 1 ] && [ $1 == "push" ]; then
	push "Update dotfiles"
elif [ $# == 2 ] && [ $1 == "push" ]; then
	push "$2"
else
	usage
fi
