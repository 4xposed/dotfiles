call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ervandew/ag'
Plug 'Raimondi/delimitMate'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'scrooloose/syntastic'

Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'
Plug 'ervandew/supertab'

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript'
Plug 'mustache/vim-mustache-handlebars'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'plasticboy/vim-markdown'
Plug 'fatih/vim-go'
Plug 'derekwyatt/vim-scala'
Plug 'keith/rspec.vim'
Plug 'othree/html5.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/javascript-libraries-syntax.vim'

Plug 'danro/rename.vim'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'

Plug 'jlanzarotta/bufexplorer'

call plug#end()

" Basic setup
set encoding=utf-8
set autowrite " :write before commands
set list listchars=tab:»·,trail:· " display trailing whitespaces
set nocursorline
set cursorcolumn
set nobackup
set nowritebackup
set noswapfile
imap jj <Esc>
let mapleader=","
filetype plugin on

"Theme settings
syntax enable
set background=dark
set clipboard=unnamed
colorscheme solarized
set ts=2 sw=2 expandtab
set number

" Mute vim
set noerrorbells
set novisualbell
set t_vb=

" easy OSX clipboard
set clipboard=unnamed,autoselect
set guioptions+=a

" Easier jump across split windows
map <C-h> :call WinMove('h')<cr>
map <C-j> :call WinMove('j')<cr>
map <C-k> :call WinMove('k')<cr>
map <C-l> :call WinMove('l')<cr>

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

set splitbelow
set splitright
set backspace=indent,eol,start

" Break bad habit
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Fix slow ruby sintax using regex engine 1
set re=1

" Saner n-N
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" Make it obvious where 100 characters is
set textwidth=100
set columns=100
set colorcolumn=+1

" Saner <->
xnoremap <  <gv
xnoremap >  >gv

" Commands in caps bound to commands with !
command! Q q
command! W w
command! E e
command! Qall qall
command! QA qall

set wildignore+=*/.git/*,*/.DS_Store,*/vendor/*,*/doc/*,*/tmp/*,*/node_modules/*,*/bower_components/*

"" Plugin stuff below
" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" NERDTree stuff
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
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

imap º <Esc>

" Airline stuff
let g:airline_powerline_fonts = 0
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='solarized'

let g:syntastic_check_on_open=1

" Strip whitespace on file save
autocmd BufWritePre * StripWhitespace

" Buffer Explorer
nnoremap <Leader>b :BufExplorer<CR>
