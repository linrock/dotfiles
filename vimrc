
filetype on
filetype indent on
filetype plugin on

syntax on
if has("gui_running")
    set guifont=Profont\ 10
    set guioptions-=T
endif

" colorscheme inkpot
" colorscheme vibrantink
" colorscheme vividchalk
" colorscheme neverland
colorscheme wombat256
" au WinEnter,FileType ini colorscheme anotherdark

let python_highlight_all = 1
highlight StatusLine cterm=NONE ctermfg=4 ctermbg=7

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Pathogen Plugins
" ----------------
" uzbl
" vim-git
" vim-haml
" vim-ruby
" vim-rails
" vim-endwise
" vim-fugitive
" vim-supertab

set nocompatible
set background=dark
set mouse=a
set ts=4
set sts=4
set sw=4
set number
set expandtab
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%v%8p
set ruler
set noerrorbells
set visualbell
set t_vb=
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

let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
noremap gn :NERDTree<Cr>

noremap j gj
noremap k gk

noremap <left> :tabp<cr>
noremap <right> :tabn<cr>
noremap <up> :bn<cr>
noremap <down> :bp<cr>

noremap ,y "*Y
noremap ,p "*p
noremap ,q :qa!<cr>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap > >gv
vnoremap < <gv

" Filetype-specific
" -----------------
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype haml setlocal ts=2 sts=2 sw=2

autocmd BufNewFile,BufRead *.ru set ft=ruby
