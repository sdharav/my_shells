set nonu
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set hls

"color desert
colorscheme monokai

filetype off
filetype plugin on
syntax on

set 	title
set statusline=%f%m%r%h%w\ [%Y]\ [0x%02.2B]%<\ %F%4v,%4l\ %3p%%\ of\ %L\ lines
set laststatus=2

set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
