all:
	git submodule init && git submodule update
	echo installing oh-my-zsh...
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

