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
    colorscheme blackboard
endif
highlight StatusLine cterm=NONE ctermfg=4 ctermbg=7

let python_highlight_all = 1
let NERDTreeIgnore=['\.pyc$', '\.pyo$']
let mapleader=","

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Pathogen Plugins
" ----------------
" CSApprox
" MRU
" ScrollColors
" nerdtree
" vim-git
" vim-haml
" vim-jade
" vim-markdown
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
set autoindent
set ttyfast
set scrolloff=5             " Keep 5 lines around the cursor
set wildmenu                " turn on wild menu :e <Tab>
set wildmode=list:longest   " set wildmenu to list choice
set nohidden
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

noremap <leader>n :NERDTreeToggle<cr>
noremap <leader>m :MRU<cr>
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

au Filetype javascript setlocal ts=2 sts=2 sw=2
au Filetype ruby setlocal ts=2 sts=2 sw=2
au Filetype haml setlocal ts=2 sts=2 sw=2
au Filetype jade setlocal ts=2 sts=2 sw=2 indentexpr=
au Filetype sass setlocal ts=2 sts=2 sw=2 indentexpr=
au Filetype yaml setlocal ts=2 sts=2 sw=2

au BufNewFile,BufRead *.ru                      set ft=ruby
au BufNewFile,BufRead *.mako                    set ft=mako
au BufNewFile,BufRead *.jade                    set ft=jade
au BufNewFile,BufRead *.jinja                   set ft=htmljinja
au BufNewFile,BufRead /etc/nginx/conf/*.conf    set ft=nginx
au BufNewFile,BufRead jquery.*.js               set ft=javascript syntax=jquery
au BufNewFile,BufRead *.ini,*/.hgrc,*/.hg/hgrc  set ft=ini
