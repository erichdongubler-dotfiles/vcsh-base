" Buffer options
set hidden
set splitbelow
set splitright

" Alias Q to do what we really want
command! Q :q
command! Qa :qa
command! QA :qa

" Overwrite files that need sudo
cmap w!! w !sudo tee % >/dev/null

" Navigation
"  Buffer nav
map <C-PageUp> :bp<CR>
map <C-PageDown> :bn<CR>

"  Line numbers
nnoremap <Leader>n :set number!<CR>

" Pane resizing
let g:winresizer_start_key = '<Leader>e'

