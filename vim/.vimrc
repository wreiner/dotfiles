set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" https://github.com/rking/ag.vim
" deprecated?
" Bundle 'rking/ag.vim'

" https://github.com/vim-airline/vim-airline
" Lean & mean status/tabline for vim that's light as air.
Bundle 'bling/vim-airline'
" https://github.com/vim-airline/vim-airline-themes
" This is the official theme repository for vim-airline
Plugin 'vim-airline/vim-airline-themes'

" https://github.com/tpope/vim-fugitive
" fugitive.vim may very well be the best Git wrapper of all time
Bundle 'tpope/vim-fugitive'

" https://github.com/wellle/targets.vim
" Targets.vim is a Vim plugin that adds various text objects to give you more targets to operate on.
Bundle 'wellle/targets.vim'

" https://github.com/tpope/vim-surround
" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more. The plugin provides mappings to easily delete, change and add such surroundings in pairs.
" help
"   https://github.com/tpope/vim-surround/blob/master/doc/surround.txt
"   http://www.vim.org/scripts/script.php?script_id=1697
Plugin 'tpope/vim-surround'

" https://github.com/scrooloose/nerdtree
" The NERDTree is a file system explorer for the Vim editor.
Plugin 'scrooloose/nerdtree'

" https://github.com/ctrlpvim/ctrlp.vim
" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
" help
"   https://www.youtube.com/watch?v=8XGueeQJsrA
Plugin 'ctrlpvim/ctrlp.vim'

" https://github.com/bkad/CamelCaseMotion
" Motions for CamelCase
Plugin 'bkad/CamelCaseMotion'

" https://github.com/yegappan/mru
" The Most Recently Used (MRU) plugin provides an easy access to a list of
" recently opened/edited files in Vim.
Plugin 'mru.vim'

" https://github.com/nathanaelkane/vim-indent-guides
" Indent Guides is a plugin for visually displaying indent levels in Vim.
Plugin 'nathanaelkane/vim-indent-guides'

" https://github.com/scrooloose/nerdcommenter
" Comment functions so powerful—no comment necessary
Plugin 'scrooloose/nerdcommenter'

call vundle#end()

filetype plugin indent on

""""""""""""""""""""""""""""""""
" .. Misc
""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=1000

" Ignore some file
set wildignore=*.swp,*.bak,*.pyc,*.class

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab

" make cursor line font bold
colorscheme default
function s:SetCursorLine()
    set cursorline
    hi cursorline cterm=bold
    " ctermbg=darkblue ctermfg=white
endfunction
autocmd VimEnter * call s:SetCursorLine()

syntax on
set report=1

"don't add two spaces after ., ?, !
set nojoinspaces

" don't tab complete binary files
set wildignore+=*.a,*.o
set wildignore+=*.gif,*.bmp,*.jpg,*.png,*.ico,*.jpeg
set wildignore+=.git,.svn

" --- searching -----
set incsearch       " show 'best match so far' as you type
set hlsearch        " hilight the items found by the search
set ignorecase      " ignores case of letters on searches
set smartcase       " Override the 'ignorecase' option if the search pattern contains upper case characters
" centers found item
nmap n :norm! nzzzv<CR>
nmap N :norm! Nzzzv<CR>

" --- keymapping -----
let mapleader=","
let g:mapleader=","

nmap <leader>p :set paste!<CR>

" <leader>T = Delete all trailing space in file
map <leader>T :%s/\s\+$//<CR>

" move up and down in long lines
nnoremap j gj
nnoremap k gk

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile
set wildmenu
set wildmode=list:longest,full

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=5

" line numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" airline
set laststatus=2
set noshowmode
let g:airline_theme='badwolf'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

if !empty(glob("~/.vim/bundle/CamelCaseMotion/plugin/camelcasemotion.vim"))
    call camelcasemotion#CreateMotionMappings('<leader>')
endif

" Nerdtree
" Sources
"   https://github.com/itscram/dotvim/blob/master/vimrc
let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

let NERDTreeIgnore=[
    \ 'node_modules$[[dir]]',
    \ '.git$[[dir]]',
    \ '.vscode$[[dir]]',
    \ '.idea$[[dir]]',
    \ '.DS_Store$[[file]]',
    \ '.swp$[[file]]',
    \ 'hdevtools.sock$[[file]]',
    \ '.synctex.gz[[file]]',
    \ '.fls[[file]]',
    \ '.fdb_latexmk[[file]]',
    \ '.aux[[file]]'
\ ]

" nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" auto add shebang for newfiles
augroup Shebang
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\"|$
  autocmd BufNewFile *.sh 0put =\"#!/bin/sh\"|$
  autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\"|$
augroup END

" Highlight current word to find cursor by hitting CTRL+K in normal mode
" http://vim.wikia.com/wiki/Highlight_current_word_to_find_cursor
" you may also hit zz to find the coursor
function VIMRCWhere()
  if !exists("s:highlightcursor")
    match Todo /\k*\%#\k*/
    let s:highlightcursor=1
  else
    match None
    unlet s:highlightcursor
  endif
endfunction
map <C-K> :call VIMRCWhere()<CR>

" https://gist.github.com/dragonken/c29123e597c6fdf022284cf36d245b64
" Get the 2-space YAML as the default when hit carriage return after the colon
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

" Highlight characters after line 80
" https://gist.github.com/romainl/eabe0fe8c564da1b6cfe1826e1482536
augroup TooLong
    autocmd!
    autocmd winEnter,BufEnter * call clearmatches() | call matchadd('ColorColumn', '\%>80v', 100)
augroup END
