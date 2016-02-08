" syntax highlight
syntax on

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" local stuff
setlocal spell spelllang=en,de
map <F2> :set spell!<CR>

" color
colorscheme industry

" https://stackoverflow.com/questions/235439/vim-80-column-layout-concerns/235970#235970
highlight OverLength ctermbg=blue ctermfg=white
match OverLength /\%81v.\+/
