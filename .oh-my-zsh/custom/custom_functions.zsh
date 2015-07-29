# Git
function gits {
	clear
	git status
}

function gitcp {
	git commit -m "$@"
	git push
}

