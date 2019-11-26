" neovim configuration.
" - native vim configurations must go before others because they redefine leader
" key, and overriding is not a thing in vim script.
" - key mappings must go after vim-plug plugin specifications because of vim-plug

" vim-plug auto installation (DO NOT CHANGE): {{{

if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = ""
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))
" }}}

"" native vim configurations ---------------------------------------------------
" functionalities: {{{
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
" set bomb
" set binary

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=2
set shiftwidth=2
set expandtab

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" Redefine iskeyword so dots, colons... are not parts of a word
set iskeyword-=.

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

set autoread
" set mouse on for all modes
set mouse=a

" Required:
filetype plugin indent on
" }}}
" visual: {{{

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" set termguicolors
syntax on
" set ruler
set nonumber
"" show cursor line
set cursorline
"" cursor is a block
set guicursor=
"" do not wrap
set nowrap
"" long line marker
set colorcolumn=91

let no_buffers_menu=1

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar always on
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" Folding
set foldenable
set foldmethod=indent foldlevel=99 foldminlines=3 foldlevelstart=10

" }}}
" key and command mappings: {{{
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
cnoreabbrev Qa qall

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>
" nunmap <CR>

" Close buffer
noremap <leader>c :bd<CR>

" Clean search (highlight)
nnoremap <space>\ :nohlsearch<CR>

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Move to last change
nnoremap gI `.

" Close all buffers but current one
command! -nargs=? -complete=buffer -bang Bonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BOnly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang Bda
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang Bda
    \ :call BufOnly('<args>', '<bang>')

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" exit terminal mode
tnoremap <Esc> <C-\><C-n>

" }}}
" autocmd: {{{

" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" Remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" }}}

"" plugins ---------------------------------------------------------------------
" search: {{{

if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
" Customize fzf colors to match color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>ff :FZF -m<CR>
nnoremap <C-t> :FZF -m<CR>
" change fzf key-binding for conformity
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }
" Resize fzf search pane
let g:fzf_layout = { 'down': '~30%' }
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
endif
" }}}
" navigation: {{{
" file navigation
Plug 'scrooloose/nerdtree'
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=0
let g:NERDTreeWinSize = 35
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <C-\> :NERDTreeToggle<CR>

" content navigation
" <leader><leader> + action
Plug 'easymotion/vim-easymotion'
" }}}
" languages: {{{

" "gc" to comment
Plug 'tpope/vim-commentary'
" language pack
Plug 'sheerun/vim-polyglot'
" ctags + vim
Plug 'ludovicchabant/vim-gutentags'
" snippets
if v:version >= 704
  "" Snippets
  Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<c-b>"
  let g:UltiSnipsEditSplit="vertical"
endif
Plug 'honza/vim-snippets'

" html
Plug 'mattn/emmet-vim'

" javascript code formatter
Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install',
      \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" code intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
set cmdheight=2
set updatetime=300
" Ctrl + space for code completion
inoremap <silent><expr> <c-space> coc#refresh()
noremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" go to defs
nmap <silent> td <Plug>(coc-definition)
nmap <silent> tt <Plug>(coc-type-definition)
nmap <silent> ti <Plug>(coc-implementation)
nmap <silent> tr <Plug>(coc-references)
" rename symbol
nmap <leader>rn <Plug>(coc-rename)
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)


" }}}
" version control: {{{

Plug 'tpope/vim-fugitive'
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>
Plug 'mhinz/vim-signify'

" }}}
" UI: {{{

" UI color adjustment
Plug 'vim-scripts/CSApprox'
Plug 'bronson/vim-trailing-whitespace'
Plug 'gruvbox-community/gruvbox'
" }}}
" miscellaneous: {{{

let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'shougo/vimproc.vim', {'do': g:make}

" sessions
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" swap splits with <leader>ww
" Plug 'wesQ3/vim-windowswap'

"" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif
" }}}

call plug#end()

"" plugin configurations -------------------------------------------------------
" languages: {{{

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=4|set shiftwidth=2|set expandtab softtabstop=2
augroup END

" }}}
" theme: {{{

if !exists('g:not_finish_vimplug')
  colorscheme gruvbox
  let g:gruvbox_contrast_dark="hard"
  set background=dark
  " colorscheme OceanicNextLight
  " colorscheme OceanicNext
endif
" }}}

" private functions: {{{
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set nowrap
    set wm=2
    set textwidth=79
  endfunction
endif

function! BufOnly(buffer, bang)
  if a:buffer == ''
    " No buffer provided, use the current buffer.
    let buffer = bufnr('%')
  elseif (a:buffer + 0) > 0
    " A buffer number was provided.
    let buffer = bufnr(a:buffer + 0)
  else
    " A buffer name was provided.
    let buffer = bufnr(a:buffer)
  endif

  if buffer == -1
    echohl ErrorMsg
    echomsg "No matching buffer for" a:buffer
    echohl None
    return
  endif

  let last_buffer = bufnr('$')

  let delete_count = 0
  let n = 1
  while n <= last_buffer
    if n != buffer && buflisted(n)
      if a:bang == '' && getbufvar(n, '&modified')
        echohl ErrorMsg
        echomsg 'No write since last change for buffer'
              \ n '(add ! to override)'
        echohl None
      else
        silent exe 'bdel' . a:bang . ' ' . n
        if ! buflisted(n)
          let delete_count = delete_count+1
        endif
      endif
    endif
    let n = n+1
  endwhile

  if delete_count == 1
    echomsg delete_count "buffer deleted"
  elseif delete_count > 1
    echomsg delete_count "buffers deleted"
  endif
endfunction
" }}}

" Include local vim config
if filereadable(expand("~/.config/nvim/local_init.vim"))
  source ~/.config/nvim/local_init.vim
endif

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
