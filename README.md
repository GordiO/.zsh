Description
-----------
Pre defined ZSH config. (TODO)



Installation
------------
Execute as user (NO ROOT):

```
	(curl https://codeload.github.com/gordio/.zsh/tar.gz/master 2>/dev/null | tar -zx -C $HOME/) && mv $HOME/.zsh{-master,} && echo 'ZDOTDIR="$HOME/.zsh"' >> $HOME/.zshenv && echo "Installed successful to $HOME/"; chsh -s $(where zsh)
```

or

```
	cd $HOME
	git clone http://github.com/gordio/.zsh
	echo 'ZDOTDIR="$HOME/.zsh"' >> $HOME/.zshenv
	
	# Set you default shell (optional)
	chsh -s $(where zsh)
```



Customize
---------

- `~/.zshrc` - You custom options
- Add plugins=(vcs_prompt) to you ~/.zshrc if need this plugin...



TODO
----

- Autoupdate with days timeout (git pull for git installation)
- Check for updates with n days timeout (curl, for systems without git)
- Fuction for list all completions and plugins with description



Development
-----------

- Completion functions must have name _<short_name> and have second file comment (not line) with max 60 chars description.
- 'Plugins' must have name <short_name> (without .zsh), and second file commen(not line) with max 60 chars description
