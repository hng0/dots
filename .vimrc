" Pathogen
execute pathogen#infect()

" Vim appearance
""""""""""""""""
colorscheme badwolf
set ruler
set number
set showcmd
set cursorline

" Vim functionalities
"""""""""""""""""""""
" Visual autocomplete for menu
set wildmenu
set history=500
set hlsearch
" search as you type
set incsearch

" Code
""""""
syntax on
set nowrap
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
" turn off search highlighting using ,<space>
nnoremap <leader><space> :nohlsearch<CR>

