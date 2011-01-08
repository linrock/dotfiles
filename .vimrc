syntax on
filetype on
filetype indent on
filetype plugin on

set background=dark
if has("gui_running")
    set guioptions+=mLlRrb
    set guioptions-=mLlRrb
    set guioptions-=T
    set guioptions+=c
    set guifont=Profont\ 8
    colorscheme blackboard
else
    colorscheme inkpot256
endif
highlight StatusLine cterm=NONE ctermfg=4 ctermbg=7

let python_highlight_all = 1
let NERDTreeIgnore=['\.pyc$', '\.pyo$']
let mapleader=","

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Pathogen Plugins
" ----------------
" vim-git
" vim-haml
" vim-ruby
" vim-rails
" vim-endwise
" vim-fugitive

set nocompatible
set mouse=a
set ts=4
set sts=4
set sw=4
set number
set expandtab
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%8p
set ruler
set noerrorbells
set t_vb=
" set autoindent
" set copyindent
set ttyfast
set scrolloff=5             " Keep 5 lines around the cursor
set wildmenu                " turn on wild menu :e <Tab>
set wildmode=list:longest   " set wildmenu to list choice
set hidden
set cryptmethod=blowfish
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set hlsearch
set incsearch
set ignorecase
set smartcase

noremap ; :
noremap j gj
noremap k gk

noremap <left> :tabp<cr>
noremap <right> :tabn<cr>
noremap <up> :bn<cr>
noremap <down> :bp<cr>

noremap <leader>n :NERDTreeToggle<cr>
noremap <leader>y "*y
noremap <leader>p "*p
noremap <leader>q :qa!<cr>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap - <C-w>-
noremap + <C-w>+
noremap <C-n> <C-w><
noremap <C-m> <C-w>>

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap > >gv
vnoremap < <gv

" Filetype-specific
" -----------------
" autocmd Filetype python set tags+=~/.vim/tags/python27.ctags
" autocmd FileType cfg colorscheme inkpot
" autocmd WinEnter,FileType ini colorscheme anotherdark

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype haml setlocal ts=2 sts=2 sw=2
autocmd Filetype jade setlocal ts=2 sts=2 sw=2 indentexpr=
autocmd Filetype sass setlocal ts=2 sts=2 sw=2 indentexpr=
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2

" autocmd Filetype css set omnifunc=csscomplete#CompleteCSS

autocmd BufNewFile,BufRead *.ru set ft=ruby
autocmd BufNewFile,BufRead *.mako set ft=mako
autocmd BufNewFile,BufRead *.jinja set ft=htmljinja
