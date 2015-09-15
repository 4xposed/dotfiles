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
Plug 'fatih/vim-go'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'
Plug 'airblade/vim-gitgutter'
Plug 'elixir-lang/vim-elixir'
Plug 'derekwyatt/vim-scala'

call plug#end()

"Theme settings
syntax enable
set background=dark
colorscheme solarized

" Display extra whitespace
set list
set listchars=tab:»\ ,trail:·,eol:¬

set ts=2 sw=2 expandtab

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:javascript_conceal_function   = "ƒ"
let g:javascript_conceal_null       = "ø"
let g:javascript_conceal_this       = "@"
let g:javascript_conceal_return     = "⇚"
let g:javascript_conceal_undefined  = "¿"
let g:javascript_conceal_NaN        = "ℕ"
let g:javascript_conceal_prototype  = "¶"
let g:javascript_conceal_static     = "•"
let g:javascript_conceal_super      = "Ω"
