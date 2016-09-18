" Prevent system-wide vimrc. Better safe than sorry.
set nocompatible
set encoding=utf-8

" Plugins
"""""""""
" Pathogen
execute pathogen#infect()

" indentLine configuration
let g:indentLine_color_term = 239
let g:indentLine_char = '|'

" ctrlp.vim configuration
" Use <C-t> to open ctrlp
let g:ctrlp_map = '<C-t>'
" Ignore these directories
set wildignore+=*/build/**
" Disable caching
let g:ctrlp_use_caching=0

" NERDTree configuration
nmap <C-\> :NERDTreeToggle<CR>

" Vim appearance
""""""""""""""""
set background=dark
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
highlight CursorColumn guibg=#262626
" Highlight matching bracket on insertion mode
set showmatch
" Highlight 81st column
set textwidth=80
set colorcolumn=+1
highlight ColorColumn ctermbg=235 guibg=red

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
" Set backspace key
set backspace=indent,eol,start
" Switch buffer without saving
set hidden
" Insert leading comment characters when pressing <enter> in insert mode
set formatoptions+=r
" Set swap file directories
set backupdir=~/.vim/backup,.,~
set directory=~/.vim/backup,.,~

" Code
""""""
" Turn on syntax highlighting
syntax on
" Prevent line wrapping
set nowrap
" Force foldenable. Better safe than sorry.
set foldenable
set foldmethod=indent foldlevel=99 foldminlines=3
" Num spaces per tab
set tabstop=4
" Num spaces used in <tab> and <BS>
set softtabstop=4
" Tab to spaces
set expandtab
" Auto-indent
set noautoindent smartindent
" number of space characters inserted for indentation
set shiftwidth=4
" Highlight trailing spaces
highlight RedundantSpaces ctermbg=red
match RedundantSpaces /\s\+$\|[^\t]\zs\t\+\|\t\zs \+/
" Highlight TODO
highlight Todo ctermfg=darkgrey ctermbg=yellow

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
" Remove trailing spaces
cnoreabbrev <silent> clean %s/[\r \t]\+$//

