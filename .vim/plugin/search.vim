set hlsearch
set ignorecase
set incsearch
set smartcase

" incsearch.vim
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" ack.vim
nnoremap <Leader>F :Ack!<Space>

" Give all things searching a serious boost
if executable('rg')
	set grepprg=rg\ --color=never\ --follow
	let g:ackprg = 'rg --vimgrep --follow --no-heading'
"	let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
"	let g:ctrlp_use_caching = 0
else
	echom 'ripgrep not found, using slower file searching'
endif

if has('python')
	let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
else
	echom 'python not found, using slower fuzzy finder'
endif

