" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin()

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'preservim/nerdtree'

call plug#end()



let mapleader = "," " map leader to comma

set number
set relativenumber
set encoding=utf-8
scriptencoding utf-8
set list
" set listchars=eol:↩,space:·,tab:··
set listchars=space:·,tab:··

set wrapmargin=8 " wrap lines when comeing within n characters from side
set linebreak " Break line at full word
set showbreak=\ \ \ \ ↪\ \  " show eliipsis at breaking

set ignorecase " Do case insensitive matching
set hlsearch " Highlight matches for search 

map <C-j> 3<C-E>
map <C-k> 3<C-Y>

" NERDTree
let NERDTreeShowHidden=1    " Show hidden files in NERDTree
