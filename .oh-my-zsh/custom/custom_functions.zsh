# Git
function gits {
	clear
	git status
}

function gitcp {
	git commit -m "$@"
	git push
}

function dclean {
    docker rm -v $(docker ps --filter status=exited -q)
    docker rmi $(docker images --filter dangling=true -q)
}
