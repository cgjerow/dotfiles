git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

ln -sf ~/dotfiles/.zshrc ~/.zshrc && source ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc && source ~/.vimrc
