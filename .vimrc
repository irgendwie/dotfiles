syntax on

set spelllang=en,de
hi clear SpellBad
hi clear SpellCap
hi SpellBad cterm=underline,bold, ctermfg=red
hi SpellCap cterm=underline,bold, ctermfg=blue

set list
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

map <F2> :set spell!<CR>
