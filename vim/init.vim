set nocompatible
filetype off

set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
set wildignore+=**/dist/*

call plug#begin("~/.config/nvim/plugged")

"Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()


let g:coc_global_extensions = [ 'coc-tsserver', 'coc-json', 'coc-prettier', 'coc-eslint' , 'coc-pairs']
autocmd FileType * let b:coc_pairs_disabled = ["<"]

let mapleader = " " " map leader to space

set path+=**
set number
set relativenumber
set encoding=utf-8
scriptencoding utf-8
set list
" set listchars=eol:↩,space:·,tab:··
set listchars=space:·,tab:··

set linebreak " Break line at full word
set showbreak=\ \ \ \ ↪\ \  " show eliipsis at breaking

set ignorecase " Do case insensitive matching
" set hlsearch " Highlight matches for search 

" Always show the status line
set laststatus=2

" Allow copy and paste from system clipboard
set clipboard=unnamed

" Spellcheck for features and markdown
au BufRead,BufNewFile *.md setlocal spell

map <C-j> 3<C-E>
map <C-k> 3<C-Y>

" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <silent> <C-b> :CtrlPBuffer<CR>

set shiftwidth=4 tabstop=4 softtabstop=2 expandtab
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab


let g:ctrlp_custom_ignore = 'build'
