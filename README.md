Description
-----------
Pre defined ZSH config. (TODO)


Installation
------------
Install as user (NO ROOT). For full install you need:

	(curl https://codeload.github.com/gordio/.zsh/tar.gz/master 2>/dev/null | tar -zx -C $HOME/ && mv $HOME/.zsh{-master,} && echo 'ZDOTDIR="$HOME/.zsh"' >> $HOME/.zshenv && cd $HOME/.zsh/func.def/ && for f in *; do ln -s ../func.def/$f ../func.d/$f;done) && echo "Installed successful to $HOME/"

or

	cd $HOME
	git clone http://github.com/gordio/.zsh
	echo 'ZDOTDIR="$HOME/.zsh"' >> $HOME/.zshenv
	
	# Set you default shell (optional)
	chsh -s $(where zsh) $USER

    # Install functions
    cp -r ~/.zsh/func.def/* ~/.zsh/func.c/


Customize
---------

- `~/.zshenv` - You custom environment (run before .zshrc)
- `~/.zshrc` - You custom options

Attached example .dircolors
