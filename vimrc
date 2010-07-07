" vim:foldmethod=marker

" colorscheme inkpot
" colorscheme vibrantink
" colorscheme vividchalk
" colorscheme neverland

syntax on
colorscheme wombat
set background=dark
let python_highlight_all = 1
filetype plugin on
" au WinEnter,FileType ini colorscheme anotherdark

set ts=4
set sw=4
set expandtab
retab 4
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%v%8p
set ruler
set ttyfast
set scrolloff=5             " Keep 5 lines around the cursor
set wildmenu                " turn on wild menu :e <Tab>
set wildmode=list:longest   " set wildmenu to list choice
set nocompatible            " disable vi compatibility

set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set hidden

" Search stuff
set hlsearch incsearch ignorecase smartcase
highlight StatusLine cterm=NONE ctermfg=4 ctermbg=7

" Nerd tree stuff
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
noremap gn :NERDTree<Cr>

" Key Mappings - {{{
" Mobility - easily move between tabs
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" For the colorscheme switcher script
map <silent><F3> :NEXTCOLOR<cr>
map <silent><F2> :PREVCOLOR<cr>

" For intuitive copying
map <C-c> "*y
map <C-c> "*Y

" Keeps visual block indented upon indent
vmap > >gv
vmap < <gv
" }}}
