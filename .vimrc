" Make vim more useful
set nocompatible

" Set syntax highlighting options.
set termguicolors
syntax on
colorscheme molokai

" we also allow italic fonts
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

" Enabled later, after Pathogen
filetype on

" size of a hard tabstop
set tabstop=4

" size of an "indent"
set shiftwidth=4
set softtabstop=4
set autoindent
set backspace=indent,eol,start
set complete-=i

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always use spaces instead of tab characters
set expandtab

" add line numbers
set number

" highlight current line
set cursorline

" incremental search and some more search features
set incsearch
set hlsearch
set ignorecase
set wrapscan

" status bar settings
set ruler
set wildmenu
set wildmode=list:longest
set wildignore=*/.git/*,*/.svn/*,*/CVS/*,*/.hg/*,*/node_modules/*
set winminheight=0

" enable extendes regex
set magic

" set title in the window and allow more characters
set title
set ttyfast

" only visual error signals
set noerrorbells
set visualbell

" set buffer encoding to utf-8 without BOM
set encoding=utf-8 nobomb

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

autocmd filetype python set expandtab

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
" Initialize plugin system
call plug#end()

let g:lightline = {
      \ 'colorscheme': 'molokai',
      \ }

" now configure the statusline
set laststatus=2
"set statusline=%F\ %m\ \ %y%=%l,%c\ %P

" treat gradle as groovy syntax
au BufNewFile,BufRead *.gradle setf groovy
