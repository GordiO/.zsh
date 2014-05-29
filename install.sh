# FIXME: 
[ -d ~/.zsh ] && (echo "~/.zsh existed, try backup to ~/.zsh_old"; mv ~/.zsh{,_old})

echo "Clone repository";
git clone --depth=1 http://github.com/gordio/.zsh || (echo "Error!"; exit -1)

echo 'ZDOTDIR="$HOME/.zsh"' >> $HOME/.zshenv

echo "Installed successful to $HOME/.zsh"

echo "If need change shell to zsh, just continue"
chsh -s $(where zsh))
