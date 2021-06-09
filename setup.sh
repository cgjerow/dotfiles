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
	HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade $1
    else
        echo "Install of $1 in progress..."
	HOMEBREW_NO_AUTO_UPDATE=1 brew install $1 
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


brew install --HEAD luajit # required for neovim development download
brew install --HEAD neovim

for tap in chrokh/tap
do
    brew tap $tap
done

for package in nvm node python tmux yarn awscli w3m htop base16-manager
do
    brew-upstall $package
done

for cask in postman iglance docker google-chrome 
do
    cask-upstall $cask --cask
done

brew cleanup


base16-manager install chriskempson/base16-shell
base16-manager clean

python3 -m pip install --upgrade pip
pip3 install base16-shell-preview


sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim --headless +PlugUpgrade +PlugUpdate +PlugClean +qa

echo "Linking dotfiles to home directory..."
echo "TODO: add prefix to identify files that should be symlinked into home directory"
mkdir ~/.config/nvim
ln -sf ~/dotfiles/shell/zshrc ~/.zshrc
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json

echo "Sourcing .zshrc"
source ~/.zshrc

echo "Done!"
