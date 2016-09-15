syntax enable
filetype off
filetype plugin on
execute pathogen#infect()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible

set modelines=0

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set ttymouse=xterm2

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <silent> <leader><space> :noh<cr>
nnoremap  <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap <leader>w <C-w>v<C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

autocmd vimenter * if !argc() | NERDTree | endif
set pastetoggle=<f2>
if exists('+undodir')
    set undodir=~/.vim/undodir
    set undofile
endif
if exists('+backupdir')
   set backupdir=~/.vim/backupdir
   set directory=~/.vim/backupdir
endif
set background=dark
set number
set colorcolumn=80
nmap <silent> <C-D> :NERDTreeToggle %<CR>
nnoremap <F3> :set nonumber!<CR>

"Syntastic
nnoremap <silent> <leader>[ :lprevious<cr>
nnoremap <silent> <leader>] :lnext<cr>
nnoremap <silent> <leader>p :lclose<cr>
nnoremap <silent> <leader>o :Errors<cr>
let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'
let g:syntastic_mode_map={ 'mode': 'active','active_filetypes': [],'passive_filetypes': ['html'] }
let g:syntastic_javascript_checkers = ['eslint']
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

let g:mocha_js_command = "!mocha --recursive --no-colors {spec}"

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

set guifont=Source\ Code\ Pro\ for\ Powerline:h12
set guioptions-=L
set guioptions-=T
set guioptions-=r

"Solarized
let g:solarized_termcolors=256
let g:solarized_bold=0
let g:solarized_underline=0
let g:solarized_italic=0
let g:solarized_termtrans = 1
colo solarized

nnoremap <F5> :UndotreeToggle<cr>
set fillchars+=vert:\ 
