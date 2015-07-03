call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'tpope/vim-sensible'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-characterize'
Plug 'vim-ruby/vim-ruby'
Plug 'ap/vim-css-color'
Plug 'othree/html5.vim'
Plug 'Shougo/unite.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'mustache/vim-mustache-handlebars'
Plug 'plasticboy/vim-markdown'

call plug#end()

"Theme settings
syntax enable
set background=dark
colorscheme solarized

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif