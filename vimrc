" vim:foldmethod=marker

" colorscheme inkpot
" colorscheme vibrantink
" colorscheme vividchalk
" colorscheme neverland
colorscheme wombat256

let python_highlight_all = 1
filetype plugin on
" au WinEnter,FileType ini colorscheme anotherdark

syntax on
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
set nocompatible            " disable vi compatibility
set hidden
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" Search stuff
set hlsearch incsearch ignorecase smartcase
highlight StatusLine cterm=NONE ctermfg=4 ctermbg=7

" Nerd tree stuff
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
noremap gn :NERDTree<Cr>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" For the colorscheme switcher script
noremap <silent><F3> :NEXTCOLOR<cr>
noremap <silent><F2> :PREVCOLOR<cr>

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <C-c> "*Y
vnoremap > >gv
vnoremap < <gv

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype haml setlocal ts=2 sts=2 sw=2
