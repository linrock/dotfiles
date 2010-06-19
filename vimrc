syntax on
" colorscheme inkpot
" colorscheme vibrantink
" colorscheme vividchalk
colorscheme lin
set background=dark

" filetype on
" au WinEnter,FileType ini colorscheme anotherdark

let python_highlight_all = 1

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

set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set hidden

" Search stuff
set hlsearch incsearch ignorecase smartcase
highlight StatusLine cterm=NONE ctermfg=4 ctermbg=7

" Nerd tree stuff
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
noremap gn :NERDTree<Cr>

" Pylint - syntax checker
autocmd FileType python compiler pylint
let g:pylint_onwrite = 0
let g:pylint_show_rate = 0

" Key Mappings
" Mobility - easily move between tabs
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" For the colorscheme switcher script
map <silent><F3> :NEXTCOLOR<cr>
map <silent><F2> :PREVCOLOR<cr>

" For intuitive copy/pasting
map <C-c> "*y
map <C-c> "*Y
map <C-v> "*p

