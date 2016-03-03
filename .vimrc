call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Xuyuanp/nerdtree-git-plugin'


Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript'

Plug 'mustache/vim-mustache-handlebars'
Plug 'plasticboy/vim-markdown'
Plug 'fatih/vim-go'
Plug 'derekwyatt/vim-scala'
Plug 'keith/rspec.vim'

Plug 'Lokaltog/vim-easymotion'
Plug 'danro/rename.vim'
Plug 'othree/html5.vim'
Plug 'tpope/vim-surround'
Plug 'roman/golden-ratio'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'DeleteTrailingWhitespace'
Plug 'tpope/vim-endwise'
Plug 'AutoClose'

call plug#end()

set encoding=utf-8
set autowrite " :write before commands
set list listchars=tab:»·,trail:· " display trailing whitespaces
set cursorline
set cursorcolumn

"Theme settings
syntax enable
set background=dark
set clipboard=unnamed
colorscheme solarized
set ts=2 sw=2 expandtab
set number

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" Mute vim
set noerrorbells
set novisualbell
set t_vb=

" easy OSX clipboard
set clipboard=unnamed,autoselect
set guioptions+=a

" Saner n-N
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Saner <->
xnoremap <  <gv
xnoremap >  >gv

command! Q q
command! W w
command! E e
command! Qall qall
command! QA qall

set wildignore+=*/.git/*,*/.DS_Store,*/vendor/*,*/doc/*

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>
imap º <Esc>

set nobackup
set nowritebackup
set noswapfile

" Make it obvious where 80 characters is
set textwidth=100
set colorcolumn=+1

let g:airline_powerline_fonts = 0
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='solarized'

let g:syntastic_check_on_open=1
