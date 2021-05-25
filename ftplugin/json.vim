" Set the comment leader for `vim-commentary`
setlocal commentstring=//\ %s

if !exists('b:vim_json_comments')
	" Auto-detect the presence of comments already in the file
	" NOTE: the regex isn't meant to be perfect, it only needs to work in most cases
	let b:vim_json_comments = search('\v(^\s*\/[/*]|\/[/*](\s|\w|[/*-])*$)', 'nwc') ? 1 : 0
endif
