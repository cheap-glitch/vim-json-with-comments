autocmd BufNewFile,BufRead *.json  setlocal filetype=json syntax=json
autocmd BufNewFile,BufRead *.jsonc setlocal filetype=json syntax=json | let b:vim_json_comments = 1
autocmd BufNewFile,BufRead *.cjson setlocal filetype=json syntax=json | let b:vim_json_comments = 1
autocmd BufNewFile,BufRead *.cjsn  setlocal filetype=json syntax=json | let b:vim_json_comments = 1
