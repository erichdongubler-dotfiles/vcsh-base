" Kill the need to use shift for :commands
nnoremap ; :

" CLI convenience binds
fun! SilentCommand()
	let command = input('Type command:')
	exec 'silent !' . command
	redraw!
endfun
nmap <Leader>! :call SilentCommand()<CR>
nmap <Leader>1 :call SilentCommand()<CR>

