" Prevent system-wide vimrc. Better safe than sorry.
set nocompatible
set encoding=utf-8

" Pathogen
execute pathogen#infect()

" indentLine configuration
""""""""""""""""""""""""""
let g:indentLine_color_term = 239
let g:indentLine_char = '|'

" ctrlp.vim configuration
"""""""""""""""""""""""""
" Use <C-t> to open ctrlp
let g:ctrlp_map = '<C-t>'
" Ignore these directories
set wildignore+=*/build/**
" Disable caching
let g:ctrlp_use_caching=0

" NERDTree configuration
""""""""""""""""""""""""
" Open tree view with <C-\>
nmap <C-\> :NERDTreeToggle<CR>

" Vim appearance
""""""""""""""""
colorscheme badwolf
" Set console title to currently open file name
set title
" Show ruler
set ruler
" Show line numbers
set number
" Show command being entered
set showcmd
" Highlight cursor's line
set cursorline
" Highlight cursor's column
set cursorcolumn
" Highlight matching bracket on insertion mode
set showmatch

" Vim functionalities
"""""""""""""""""""""
" Visual autocomplete for menu
set wildmenu
" Keep 50 commands in history
set history=50
" Highlight matched search pattern
set hlsearch
" Search as you type
set incsearch

" Code
""""""
" Turn on syntax highlighting
syntax on
" Prevent line wrapping
set nowrap
" Force foldenable. Better safe than sorry.
set foldenable
set foldmethod=indent foldlevel=99 foldminlines=3
set tabstop=4
" Num spaces per tab
set softtabstop=4
" Tab to spaces
" set expandtab
set noautoindent smartindent

" Key mapping
"""""""""""""
" Turn off search highlighting using ,<space>
nnoremap <leader><space> :nohlsearch<CR>
" Indent by <tab> in visual mode
vmap <tab> >
vmap <s-tab> <
" Indent by <tab><tab> in normal mode
nmap <tab><tab> >>
nmap <s-tab><s-tab> <<
" Navigate splits
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
imap <C-h> <C-o><C-w>h
imap <C-j> <C-o><C-w>j
imap <C-k> <C-o><C-w>k
imap <C-l> <C-o><C-w>l
