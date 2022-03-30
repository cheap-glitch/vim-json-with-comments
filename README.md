# 🐏 vim-json-with-comments

[![License](https://shields.io/github/license/cheap-glitch/vim-json-with-comments)](LICENSE)
[![Latest release](https://shields.io/github/v/release/cheap-glitch/vim-json-with-comments?sort=semver&label=latest%20release&color=green)](https://github.com/cheap-glitch/vim-json-with-comments/releases/latest)

This is a fork of [vim-json](https://github.com/elzr/vim-json) that adds support
for C-style comments inside JSON files.

## Features

 * All the goodness of `vim-json`:
   precise highlighting, warnings for syntax errors, quote concealing, syntactic
   folding, etc.
 * Support for single-line (`//`) and multi-line comments (`/**/`)
 * Smart file-by-file enabling of comments and spellchecking

## Installation

The recommended way of installing plugins in (Neo)Vim is through a plugin manager.

With [dein.vim](https://github.com/Shougo/dein.vim):

```vim
dein#add('cheap-glitch/vim-json-with-comments')
```

With [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'cheap-glitch/vim-json-with-comments'
```

## Usage

This plugin is meant to be used as a drop-in replacement for `vim-json`.

By default, comments  will be enabled in  a JSON file _only if  there is already
at  least  one  valid  comment  in  it_. Otherwise  it  will  act  the  same  as
`vim-json`,  i.e.  highlight newly  entered  comments  as errors  (provided  the
`vim_json_warnings` option is enabled, which it is by default).

### Options

Configure  the plugin  by  setting  some global  variables  in  your `.vimrc`  /
`init.vim`:

 * `g:vim_json_warnings`: set to `1` to  highlight syntax errors in red, `0` not
   to (default: `1`)

 * `g:vim_json_comments`:  set to `1` to  always enable comments for  every JSON
   file, `0` to disable them everywhere (default: `0`)

 * `g:vim_json_spellcheck_only_comments`:  set to `1` to  limit spellchecking to
   comments, `0` to spellcheck the whole file (default: `0`)

Example:

```vim
let g:vim_json_warnings = 0
let g:vim_json_comments = 1
let g:vim_json_spellcheck_only_comments = 1
```

Every one of these settings can be  manually overridden in the current buffer by
setting local buffer variables during the editing process, e.g.

```vim
:let b:vim_json_comments=0<CR>
```

and then reloading the current buffer with `:e`.

### Quote concealing

To enable quote concealing, set the `conceallevel` option to `2`.

```vim
" To enable it everywhere:
set conceallevel=2

" To enable it only for JSON files:
autocmd FileType json setlocal conceallevel=2
```

## Contributing

Contributions are welcomed! Please open an issue before submitting substantial changes.

<!-- Contributions are welcome! Note that  this project uses [vint](https://github.com/Vimjas/vint) for linting -->
<!-- and [vader](https://github.com/junegunn/vader.vim) for testing, so you will need to install them both in order to -->
<!-- validate your changes. -->

## Acknowledgments

This plugin is largely based on the work of [Eli Parra](https://github.com/elzr).
Many thanks to him!

## Related

 * [`jsonc`](https://github.com/onury/jsonc) – Node.js module to parse JSON with comments
 * [`node-jsonc-parser`](https://github.com/Microsoft/node-jsonc-parser) – Node.js module to parse and manipulate JSONC
 * [`strip-json-comments`](https://github.com/sindresorhus/strip-json-comments) – Node.js module to remove comments from JSON data

## License

ISC
