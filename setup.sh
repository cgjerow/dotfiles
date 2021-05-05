echo "Upstall of Homebrew in progress..."
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

brew-upstall () 
{
    if brew ls --versions $1 > /dev/null
    then
        echo "Upgrade of $1 in progress..."
	brew upgrade $1
    else
        echo "Install of $1 in progress..."
	brew install $1 
    fi
    echo "Upstall of $1 completed."
}

cask-upstall()
{
    if brew upgrade --cask $1 > /dev/null
    then
	echo "$1 already installed"
    else
	echo "Install of $1 in progress..."
	brew install --cask $1 $2
    fi
    echo "Upstall of $1 completed."
}

for package in node python tmux yarn w3m htop
do
    brew-upstall $package
done

for cask in google-chrome iglance
do
    cask-upstall $cask --cask
done

echo "Updating vim vundles..."
[ -d 	"~/.vim/bundle/Vundle.vim" ] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim # clone if directory doesn't exist
vim +PluginInstall +PluginClean +qall


echo "Linking dotfiles to home directory..."
ln -sf ~/dotfiles/zshrc ~/.zshrc && source ~/.zshrc
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf

echo "Sourcing .zshrc"
source ~/.zshrc

echo "Done!"
