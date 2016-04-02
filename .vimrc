let mapleader=","

noremap ; :
noremap j gj
noremap k gk

noremap <leader>m :MRU<cr>
noremap <leader>q :qa!<cr>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap - <C-w>-
noremap + <C-w>+
noremap <C-n> <C-w><
noremap <C-m> <C-w>>

vnoremap <leader>h :!tidy -q -i<cr><cr>
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap > >gv
vnoremap < <gv

"----------

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-commentary'
Bundle 'mileszs/ack.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'evanmiller/nginx-vim-syntax'
Bundle 'groenewege/vim-less'
Bundle 'cakebaker/scss-syntax.vim'

Bundle 'matchit.zip'
Bundle 'flazz/vim-colorschemes'
Bundle 'zeis/vim-kolor'
Bundle 'morhetz/gruvbox'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'mattn/emmet-vim'
Bundle 'vim-scripts/ZoomWin'
Bundle 'derekwyatt/vim-scala'
Bundle 'jnwhiteh/vim-golang'
Bundle 'mxw/vim-jsx'
Bundle 'othree/yajs.vim'
Bundle 'keith/swift.vim'
Bundle 'chriskempson/base16-vim'
Bundle 'atelierbram/vim-colors_atelier-schemes'
Bundle 'nanotech/jellybeans.vim'
" Bundle 'godlygeek/csapprox'

" Bundle 'kballard/vim-swift'
" Bundle 'isRuslan/vim-es6'

Bundle 'Lokaltog/vim-powerline'
Bundle 'mustache/vim-mustache-handlebars'
" let g:Powerline_symbols = 'fancy'


set encoding=utf-8
set termencoding=utf-8

Bundle 'junegunn/goyo.vim'
let g:goyo_width="80"
noremap <leader><space> :Goyo<cr>

let g:yankring_history_dir="~"
let g:yankring_history_file=".yankring"
let g:yankring_zap_keys = 'f F t T / ?'
noremap <leader>y :YRShow<cr>

Bundle 'kien/ctrlp.vim'
" let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_custom_ignore = { 'dir': 'tmp$|\.git$\|\.hg$\|\.svn$' }
noremap <leader>p :CtrlP<cr>

Bundle 'altercation/vim-colors-solarized'
let g:solarized_termtrans=0
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"

Bundle 'scrooloose/nerdtree'
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.sock$']
noremap <leader>n :NERDTreeToggle<cr>
noremap <leader>r :NERDTreeFind<cr>

" call NERDTreeAddKeyMap({
"         \ 'key': 'yy',
"         \ 'callback': 'NERDTreeYankCurrentNode',
"         \ 'quickhelpText': 'put full path of current node into the default register' })

" function! NERDTreeYankCurrentNode()
"   let n = g:NERDTreeFileNode.GetSelected()
"     if n != {}
"     call setreg('"', n.path.str())
"   endif
" endfunction

let loaded_matchparen = 1
let python_highlight_all = 1
let &t_Co=256

"----------

syntax on
filetype on
filetype off
filetype indent on
filetype plugin on

if has("gui_running")
  " set guioptions+=mLlRrb
  " set guioptions-=mLlRrb
  " set guioptions-=T
  " set guioptions+=c
endif

highlight StatusLine cterm=NONE ctermfg=4 ctermbg=7

au Filetype javascript setlocal ts=2 sts=2 sw=2
au Filetype ruby setlocal ts=2 sts=2 sw=2
au Filetype haml setlocal ts=2 sts=2 sw=2 indentexpr=
au Filetype html setlocal ts=2 sts=2 sw=2 indentexpr=
au Filetype eruby setlocal ts=2 sts=2 sw=2 indentexpr=
au Filetype htmldjango setlocal ts=2 sts=2 sw=2 indentexpr=
au Filetype jade setlocal ts=2 sts=2 sw=2 indentexpr=
au Filetype sass setlocal ts=2 sts=2 sw=2 indentexpr=
au Filetype yaml setlocal ts=2 sts=2 sw=2
au Filetype python setlocal ts=4 sts=4 sw=4

au BufNewFile,BufRead *.ejs                               set filetype=html
au BufNewFile,BufRead *.ru,*.god,*.rabl                   set ft=ruby
au BufNewFile,BufRead *.eco                               set ft=eco
au BufNewFile,BufRead *.mako                              set ft=mako
au BufNewFile,BufRead *.jade                              set ft=jade
au BufNewFile,BufRead *.less                              set ft=less
au BufNewFile,BufRead *.jinja                             set ft=htmljinja
au BufNewFile,BufRead *.es6                               set ft=javascript
au BufNewFile,BufRead *.coffee                            set ft=coffee
au BufNewFile,BufRead *.mobile.erb                        set ft=eruby.html
au BufNewFile,BufRead jquery.*.js                         set ft=javascript syntax=jquery
au BufNewFile,BufRead *.ini,*/.hgrc,*/.hg/hgrc            set ft=ini
au BufNewFile,BufRead nginx*.conf,/etc/nginx/conf/*.conf  set ft=nginx

autocmd BufReadPre * if getfsize(expand("%")) > 10000000 | syntax clear | endif

set background=dark
set mouse=
set backspace=2
set ts=2
set sts=2
set sw=2
set number
set expandtab
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%8p
set ruler
set gdefault
set noerrorbells
set t_vb=
if $TMUX == ''
  set clipboard+=unnamed
endif
set vb
set autoindent
set ttyfast
set scrolloff=5             " Keep 5 lines around the cursor
set wildmenu                " turn on wild menu :e <Tab>
set wildmode=list:longest   " set wildmenu to list choice
set wildignore=*/tmp/*,*.so,*.swp,*.zip,*.pyc
set nohidden
set cryptmethod=blowfish
set hlsearch
set noantialias
set nocompatible
set nomodeline
set incsearch
set ignorecase
set smartcase
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap

colorscheme solarized
