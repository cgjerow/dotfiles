First, link up .vimrc in home directory to this directory's .vimrc file
ln -s ~/my_preferences/.vimrc ~/

Then do the same for bashrc
ln -s ~/my_preferences/.bashrc ~/

When setting up a new computer, you need to set up vundle with:
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

After running these, you should be able to start up vim with the right configuration. 
