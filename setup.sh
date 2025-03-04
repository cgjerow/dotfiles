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

for tap in chrokh/tap hashicorp/tap
do
    brew tap $tap
done

for package in node nvm python tmux yarn luajit neovim gh glab w3m htop zsh-autosuggestions ripgrep cmake gcc-arm-none-eabi ngrok/ngrok/ngrok hashicorp/tap/terraform ktlint ktfmt stylua rust
do
    brew-upstall $package
done

for cask in iglance
do
    cask-upstall $cask --cask
done

brew cleanup

yarn global add eslint

python3 -m pip install --upgrade pip


# install sdk man for Java Version Management
# curl -s "https://get.sdkman.io" | bash

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim --headless +PlugUpgrade +PlugUpdate +PlugClean +qa

function gitCloneOrPull() {
    (cd ~/dotfiles/plugins ; git clone --depth 1 -- "$1" $2 &> /dev/null) || (cd ~/dotfiles/plugins/"$2" ; git pull)
}

gitCloneOrPull https://github.com/marlonrichert/zsh-autocomplete.git zsh-autocomplete
gitCloneOrPull https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting
gitCloneOrPull https://github.com/zsh-users/zsh-history-substring-search.git zsh-history-substring-search
gitCloneOrPull https://github.com/zsh-users/zsh-history-substring-search.git zsh-history-substring-search
gitCloneOrPull git@github.com:cgjerow/kickstart.nvim.git nvim
git config --global push.default current

echo "Linking dotfiles to home directory..."
echo "TODO: add prefix to identify files that should be symlinked into home directory"
ln -sf ~/dotfiles/plugins/nvim ~/.config
ln -sf ~/dotfiles/shell/zshrc ~/.zshrc
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

echo "Sourcing .zshrc"
source ~/.zshrc

echo "Done!"

