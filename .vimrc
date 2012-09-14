call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype on
filetype indent on
filetype plugin on

let g:yankring_history_dir="~"
let g:yankring_history_file=".yankring"

let g:solarized_termtrans=0
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"

" let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_custom_ignore = { 'dir': '\.git$\|\.hg$\|\.svn$' }

let loaded_matchparen = 1
let python_highlight_all = 1
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.sock$']
let mapleader=","

if has("gui_running")
  set guioptions+=mLlRrb
  set guioptions-=mLlRrb
  set guioptions-=T
  set guioptions+=c
  set guifont=Profont:h9
endif

highlight StatusLine cterm=NONE ctermfg=4 ctermbg=7

noremap ; :
noremap j gj
noremap k gk

noremap <leader>n :NERDTreeToggle<cr>
noremap <leader>m :MRU<cr>
noremap <leader>y :YRShow<cr>
noremap <leader>p :CtrlP<cr>
noremap <leader>q :qa!<cr>
noremap <leader>a :Ack

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap - <C-w>-
noremap + <C-w>+
noremap <C-n> <C-w><
noremap <C-m> <C-w>>

noremap <silent> <F11> :YRShow<cr>

vnoremap <leader>h :!tidy -q -i<cr><cr>
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap > >gv
vnoremap < <gv

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

au BufNewFile,BufRead *.ru                      set ft=ruby
au BufNewFile,BufRead *.mako                    set ft=mako
au BufNewFile,BufRead *.jade                    set ft=jade
au BufNewFile,BufRead *.jinja                   set ft=htmljinja
au BufNewFile,BufRead /etc/nginx/conf/*.conf    set ft=nginx
au BufNewFile,BufRead jquery.*.js               set ft=javascript syntax=jquery
au BufNewFile,BufRead *.ini,*/.hgrc,*/.hg/hgrc  set ft=ini

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
set clipboard=unnamed
set vb
set autoindent
set ttyfast
set scrolloff=5             " Keep 5 lines around the cursor
set wildmenu                " turn on wild menu :e <Tab>
set wildmode=list:longest   " set wildmenu to list choice
set wildignore=*/tmp/*,*.so,*.swp,*.zip,*.pyc
set nohidden
set cryptmethod=blowfish
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set hlsearch
set noantialias
set nocompatible
set incsearch
set ignorecase
set smartcase

colorscheme solarized
