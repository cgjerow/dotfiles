[ -d 	"~/.vim/bundle/Vundle.vim" ] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim # clone if directory doesn't exist
vim +PluginInstall +qall

ln -sf ~/dotfiles/.zshrc ~/.zshrc && source ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
