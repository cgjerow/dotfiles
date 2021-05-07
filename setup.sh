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

for tap in chrokh/tap
do
    brew tap $tap
done

for package in node python tmux yarn w3m htop base16-manager
do
    brew-upstall $package
done

for cask in google-chrome iglance
do
    cask-upstall $cask --cask
done

base16-manager install chriskempson/base16-shell
base16-manager install chriskempson/base16-vim
bae16-manager clean

python3 -m pip install --upgrade pip
pip3 install base16-shell-preview

echo "Updating vim vundles..."
[ -d 	"~/.vim/bundle/Vundle.vim" ] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim # clone if directory doesn't exist
vim +PluginInstall +PluginClean +qall


echo "Linking dotfiles to home directory..."
echo "TODO: add prefix to identify files that should be symlinked into home directory"
ln -sf ~/dotfiles/shell/zshrc ~/.zshrc
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

echo "Sourcing .zshrc"
source ~/.zshrc

echo "Done!"
