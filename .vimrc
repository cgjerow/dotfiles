""" Vundle Plugin Manager
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'flazz/vim-colorschemes'
Plugin 'atelierbram/Base2Tone-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
call vundle#end()            " required
""" end vundle



" line enables syntax highlighting by default.
syntax on
" colorscheme challenger_deep
" colorscheme 256_noir 
" colorscheme murphy
" colorscheme old_fashioned
" colorscheme Base2Tone_DesertDark
" colorscheme dogrun
colorscheme abstract

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set linebreak           " Break line at full word
set showcmd		" Show (partial) command in status line.
set number		" Show line number
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set relativenumber	" Have relative numbers from cur line
set hlsearch		" Highlight matches for search 
let NERDTreeShowHidden=1    " Show hidden files in NERDTree
"set smartcase		" Do smart case matching


" Custom Mappings
let maploader = "," " map leader to comma
map <C-k> <C-E>
