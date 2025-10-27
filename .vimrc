" Basic Vim Configuration for Modern Usage
" Save this as ~/.vimrc (Linux/Mac) or ~/_vimrc (Windows)

" === GENERAL SETTINGS ===
set nocompatible              " Disable vi compatibility
set encoding=utf-8            " Set UTF-8 encoding
set fileencoding=utf-8        " File encoding

" === APPEARANCE ===
set number                    " Show line numbers
set cursorline                " Highlight current line
set cursorcolumn              " Vertical ruler
set showmatch                 " Highlight matching brackets
set ruler                     " Show cursor position
set laststatus=2              " Always show status line
set showcmd                   " Show command in status line
set wildmenu                  " Enhanced command completion
set wildmode=longest:full,full " Command completion mode

" === SYNTAX AND COLORS ===
syntax enable                 " Enable syntax highlighting

" === INDENTATION ===
set autoindent                " Auto indent
set smartindent               " Smart indent
set tabstop=4                 " Tab width
set shiftwidth=4              " Indent width
set expandtab                 " Use spaces instead of tabs
set smarttab                  " Smart tab handling

" === SEARCH ===
set hlsearch                  " Highlight search results
set incsearch                 " Incremental search
set ignorecase                " Case insensitive search
set smartcase                 " Case sensitive if uppercase used

" === EDITING ===
set backspace=indent,eol,start " Better backspace behavior
set wrap                      " Wrap long lines
set linebreak                 " Break lines at word boundaries
set scrolloff=8               " Keep 8 lines above/below cursor
set sidescrolloff=8           " Keep 8 columns left/right of cursor

" === FILES AND BACKUP ===
set autoread                  " Auto reload changed files
set hidden                    " Allow hidden buffers
set nobackup                  " No backup files
set nowritebackup             " No backup before overwriting
set noswapfile                " No swap files

" === PERFORMANCE ===
set lazyredraw                " Don't redraw during macros
set ttyfast                   " Fast terminal connection

" === KEY MAPPINGS ===
" Set leader key to space
let mapleader = " "

" Clear search highlighting with Esc
nnoremap <silent> <Esc> :nohlsearch<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Toggle line numbers
nnoremap <leader>n :set number!<CR>

" === MOUSE SUPPORT ===
if has('mouse')
  set mouse=a                 " Enable mouse in all modes
endif

" === CLIPBOARD ===
if has('clipboard')
  set clipboard=unnamed       " Use system clipboard
  if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
  endif
endif

" === AUTO COMMANDS ===
" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" === STATUS LINE ===
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

" === PLUGINS ===
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Add your plugins here
Plug 'sheerun/vim-polyglot'

" Initialize plugin system
call plug#end()

