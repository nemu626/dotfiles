" ~/.vimrc - Vim Configuration

" ==========================================
" General Settings
" ==========================================
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

" ==========================================
" UI
" ==========================================
set number
" set relativenumber
set cursorline
set showmatch
set showcmd
set showmode
set laststatus=2
set ruler
set wildmenu
set wildmode=longest:full,full
set scrolloff=8
set sidescrolloff=8
set signcolumn=yes
set termguicolors
set background=dark

" ==========================================
" Indentation
" ==========================================
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
filetype plugin indent on

" ==========================================
" Search
" ==========================================
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" ==========================================
" Behavior
" ==========================================
set hidden
set backspace=indent,eol,start
set clipboard=unnamedplus
set mouse=a
set splitbelow
set splitright
set nowrap
set noswapfile
set nobackup
set nowritebackup
set undofile
set undodir=~/.vim/undodir
set updatetime=300
set timeoutlen=500
set history=1000

" ==========================================
" Key Mappings
" ==========================================
let mapleader = " "

" Better escape
inoremap jk <Esc>
inoremap kj <Esc>

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Clear search highlight
nnoremap <Esc> :nohlsearch<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Buffer navigation
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" ==========================================
" Autocommands
" ==========================================
augroup vimrc
    autocmd!
    " Remove trailing whitespace on save
    autocmd BufWritePre * :%s/\s\+$//e
    " Return to last edit position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " Auto resize splits
    autocmd VimResized * tabdo wincmd =
augroup END

" ==========================================
" File Type Settings
" ==========================================
augroup filetypes
    autocmd!
    autocmd FileType html,css,javascript,typescript,json,yaml setlocal tabstop=2 shiftwidth=2
    autocmd FileType python setlocal tabstop=4 shiftwidth=4
    autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd FileType make setlocal noexpandtab
augroup END

" ==========================================
" Netrw (File Explorer)
" ==========================================
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

nnoremap <leader>e :Lexplore<CR>

" ==========================================
" Colors (Basic Catppuccin-like)
" ==========================================
syntax enable

" Create undodir if not exists
if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
endif
