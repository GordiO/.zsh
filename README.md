Description
-----------
Pre defined ZSH config. (TODO)


Installation
------------
Install as user (NO ROOT). For full install you need:

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
