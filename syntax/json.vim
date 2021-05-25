" Vim syntax file
" Language:    JSON
" Maintainer:  cheap glitch <cheap.glitch@gmail.com>
" Version:     0.9.0
" URL:         https://github.com/cheap-glitch/vim-json-with-comments
" Forked From: https://github.com/elzr/vim-json

if !exists('main_syntax')
	if exists('b:current_syntax')
		finish
	endif
	let main_syntax = 'json'
endif

let s:warnings = exists('b:vim_json_warnings') ? (b:vim_json_warnings != 0 ? 1 : 0) : (!exists('g:vim_json_warnings') || g:vim_json_warnings != 0 ? 1 : 0)
let s:comments = exists('b:vim_json_comments') ? (b:vim_json_comments != 0 ? 1 : 0) : ( exists('g:vim_json_comments') && g:vim_json_comments != 0 ? 1 : 0)
let s:spellcheck_only_comments = exists('b:vim_json_spellcheck_only_comments')
\	? (b:vim_json_spellcheck_only_comments != 0 ? 1 : 0)
\	: (exists('g:vim_json_spellcheck_only_comments') && g:vim_json_spellcheck_only_comments != 0 ? 1 : 0)

" Syntax: Keywords
" Separated into a match and region because a region by itself is always greedy
syn match jsonKeywordMatch /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*\:/ contains=jsonKeyword
if has('conceal')
	syn region jsonKeyword matchgroup=jsonQuote start='"' end=/"\ze[[:blank:]\r\n]*\:/ contained concealends
else
	syn region jsonKeyword matchgroup=jsonQuote start='"' end=/"\ze[[:blank:]\r\n]*\:/ contained
endif

" Syntax: Strings
" Separated into a match and region because a region by itself is always greedy
" This needs to come after the keywords or else a JSON encoded string will break the syntax
syn match jsonStringMatch /"\([^"]\|\\\"\)\+"\ze[[:blank:]\r\n]*[,}\]]/ contains=jsonString
if has('conceal')
	syn region jsonString oneline matchgroup=jsonQuote start='"' skip=/\\\\\|\\"/ end='"' contains=jsonEscape contained concealends
else
	syn region jsonString oneline matchgroup=jsonQuote start='"' skip=/\\\\\|\\"/ end='"' contains=jsonEscape contained
endif

" Syntax: Warnings
if s:warnings
	" Strings should always be enclosed with quotes
	syn match jsonNoQuotesError     '\<[[:alpha:]][[:alnum:]]*\>'
	syn match jsonTripleQuotesError '"""'

	" JSON does not allow strings with single quotes, unlike JavaScript
	syn region jsonStringSQError oneline start=+'+ skip=+\\\\\|\\"+ end=+'+

	" An integer part of 0 followed by other digits is not allowed
	syn match jsonNumError '-\=\<0\d\.\d*\>'

	" Decimals smaller than one should begin with 0 (so .1 should be 0.1)
	syn match jsonNumError '\:\@<=[[:blank:]\r\n]*\zs\.\d\+'

	" No semicolons in JSON
	syn match jsonSemicolonError ';'

	" No trailing comma after the last element of arrays or objects
	syn match jsonTrailingCommaError ',\_s*[}\]]'

	" Missing commas between elements
	syn match jsonMissingCommaError /\("\|\]\|\d\)\zs\_s\+\ze"/
	syn match jsonMissingCommaError /\(\]\|\}\)\_s\+\ze"/       " Arrays & objects as values
	syn match jsonMissingCommaError /}\_s\+\ze{/                " Objects as elements in an array
	syn match jsonMissingCommaError /\(true\|false\)\_s\+\ze"/  " `true` & `false` as value

	" No comments in JSON, see http://stackoverflow.com/questions/244777/can-i-comment-a-json-file
	if s:comments
		syn match jsonCommentError '//.*'
		syn match jsonCommentError '\(/\*\)\|\(\*/\)'
	endif
endif

" Syntax: Comments
" Taken from https://github.com/pangloss/vim-javascript/blob/585ad542834fd3d9e47e0ef59abafd69c696c80d/syntax/javascript.vim#L201
if s:comments
	if s:spellcheck_only_comments
		syn region jsComment start=+//+  end=/$/   contains=jsCommentTodo,@Spell extend keepend
		syn region jsComment start=+/\*+ end=+\*/+ contains=jsCommentTodo,@Spell extend keepend fold
	else
		syn region jsComment start=+//+  end=/$/   contains=jsCommentTodo extend keepend
		syn region jsComment start=+/\*+ end=+\*/+ contains=jsCommentTodo extend keepend fold
	endif
	syn keyword jsCommentTodo contained TODO FIXME XXX TBD NOTE

endif

" Syntax: Braces
syn region jsonFold matchgroup=jsonBraces start='{'  end=/}\(\_s\+\ze\("\|{\)\)\@!/ transparent fold
syn region jsonFold matchgroup=jsonBraces start='\[' end=/]\(\_s\+\ze"\)\@!/        transparent fold

" Syntax: Null
syn keyword jsonNull null

" Syntax: Boolean
syn match jsonBoolean /\(true\|false\)\(\_s\+\ze"\)\@!/

" Syntax: Numbers
syn match jsonNumber '-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>\ze[[:blank:]\r\n]*[,}\]]'

" Syntax: Escape sequences
syn match jsonEscape '\\["\\/bfnrt]' contained
syn match jsonEscape '\\u\x\{4}'     contained

" Syntax: Concealed characters
syn match jsonNoise /\%(:\|,\)/

" Define the default highlighting
hi def link jsonString  String
hi def link jsonTest    Label
hi def link jsonEscape  Special
hi def link jsonNumber  Number
hi def link jsonBraces  Delimiter
hi def link jsonNull    Function
hi def link jsonBoolean Boolean
hi def link jsonKeyword Label
hi def link jsonQuote   Quote
hi def link jsonNoise   Noise
if s:warnings
	hi def link jsonNumError           Error
	hi def link jsonSemicolonError     Error
	hi def link jsonTrailingCommaError Error
	hi def link jsonMissingCommaError  Error
	hi def link jsonStringSQError      Error
	hi def link jsonNoQuotesError      Error
	hi def link jsonTripleQuotesError  Error
	if s:comments
		hi def link jsonCommentError Error
	endif
endif
if s:comments
	hi def link jsComment Comment
endif

let b:current_syntax = 'json'
if main_syntax ==? 'json'
	unlet main_syntax
endif
