" vim:foldmethod=marker

" colorscheme inkpot
" colorscheme vibrantink
" colorscheme vividchalk
" colorscheme neverland
colorscheme wombat256
" au WinEnter,FileType ini colorscheme anotherdark

let python_highlight_all = 1
filetype on
filetype indent on
filetype plugin on

" Pathogen
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

syntax on
set nocompatible            " disable vi compatibility
set background=dark
set mouse=a
set ts=4
set sw=4
set expandtab
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%v%8p
set ruler
set ttyfast
set scrolloff=5             " Keep 5 lines around the cursor
set wildmenu                " turn on wild menu :e <Tab>
set wildmode=list:longest   " set wildmenu to list choice
set hidden
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" Search stuff
set hlsearch incsearch
set ignorecase smartcase
highlight StatusLine cterm=NONE ctermfg=4 ctermbg=7

" Nerd tree stuff
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
noremap gn :NERDTree<Cr>

" Navigation/shortcuts
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <F7> :tabnext<cr>
noremap <F8> :tabprev<cr>
noremap <C-q> :qa!<cr>

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <C-c> "*Y
vnoremap > >gv
vnoremap < <gv

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype haml setlocal ts=2 sts=2 sw=2
