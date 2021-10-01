""""""""""""""""""""""""""""""""
" Installed and activated plugins
""""""""""""""""""""""""""""""""

" Install plug as plugin manager
"if empty(glob('~/.vim/autoload/plug.vim'))
  "silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    "\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Lean & mean status/tabline for vim that's light as air.
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

" This is the official theme repository for vim-airline
" https://github.com/vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" fugitive.vim may very well be the best Git wrapper of all time
" https://github.com/tpope/vim-fugitive
" Plug 'tpope/vim-fugitive'

" Targets.vim is a Vim plugin that adds various text objects to give you more
" targets to operate on.
" https://github.com/wellle/targets.vim
Plug 'wellle/targets.vim'

" A very fast, multi-syntax context-sensitive color name highlighter
" https://github.com/ap/vim-css-color
Plug 'ap/vim-css-color'

" Surround.vim is all about surroundings: parentheses, brackets, quotes, XML
" tags, and more. The plugin provides mappings to easily delete, change and
" add such surroundings in pairs.
" https://github.com/tpope/vim-surround
" Help
"   https://github.com/tpope/vim-surround/blob/master/doc/surround.txt
"   http://www.vim.org/scripts/script.php?script_id=1697
Plug 'tpope/vim-surround'

" The NERDTree is a file system explorer for the Vim editor.
" https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree'

" Indent Guides is a plugin for visually displaying indent levels in Vim.
" https://github.com/nathanaelkane/vim-indent-guides
Plug 'nathanaelkane/vim-indent-guides'

" Comment stuff out.
" https://github.com/tpope/vim-commentary
" ma jj gc 'a
Plug 'tpope/vim-commentary'

" AI auto complete
" https://tabnine.com/install
Plug 'zxqfl/tabnine-vim'

" Bundle of fzf-based commands and mappings
" https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf.vim'

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'

" Python linter (needs flake8 installed)
Plug 'nvie/vim-flake8'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

""""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""""

"
" filetype plugin indent on

" Sets how many lines of history VIM has to remember
set history=1000

" Ignore some file types
set wildignore=*.swp,*.bak,*.pyc,*.class

" Setup indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab

" Report only affected line count > 1
set report=1

" Don't add two spaces after ., ?, !
set nojoinspaces

" don't tab complete binary files
set wildignore+=*.a,*.o
set wildignore+=*.gif,*.bmp,*.jpg,*.png,*.ico,*.jpeg
set wildignore+=.git,.svn

" --- searching -----
" show 'best match so far' as you type
set incsearch

" hilight the items found by the search
set hlsearch

" ignores case of letters on searches
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case characters
set smartcase

" centers found item
nmap n :norm! nzzzv<CR>
nmap N :norm! Nzzzv<CR>

" --- Color and theme settings
" Enable xterm colors
if $TERM == "xterm-256color"
    set t_Co=256
endif

" Change colors of popup
" https://vi.stackexchange.com/a/12665
highlight Pmenu ctermbg=gray guibg=gray

" make cursor line font bold
"colorscheme default
function s:SetCursorLine()
    set cursorline
    hi cursorline cterm=bold
endfunction
autocmd VimEnter * call s:SetCursorLine()

" Switch on syntax highlighting
syntax on

" --- Non plugin keymapping -----

" Space is mapleader
let mapleader=" "
let g:mapleader=" "

" Activate paste mode with <leader>p
nmap <leader>p :set paste!<CR>

" Delete all trailing space in file
map <leader>T :%s/\s\+$//<CR>

" Substitute the word under the cursor.
" https://github.com/jeremyckahn/dotfiles/blob/master/.vimrc
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Quickly get rid of highlighting
noremap <leader>h :noh<CR>
" Move up and down in long lines
nnoremap j gj
nnoremap k gk

" --- ag mappings
" Bind K to grep word under cursor
nnoremap K :silent grep! "\b\s?<C-R><C-W>\b"<CR>:cw<CR>:redr!<CR>
"nnoremap K :grep! \"\b<C-R><C-W>\b"<CR>:cw<CR>

" Bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" --- Misc settings
" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" auto add shebang for newfiles
augroup Shebang
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\"|$
  autocmd BufNewFile *.sh 0put =\"#!/bin/sh\"|$
  autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\"|$
augroup END

" --- Filetype settings
" https://gist.github.com/dragonken/c29123e597c6fdf022284cf36d245b64
" Get the 2-space YAML as the default when hit carriage return after the colon
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

" --- Folding configuration
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle relative line numbering with ctrl+n
function! NumberToggle()
    " ! toggles on/off
    " https://stackoverflow.com/a/32318323
    set relativenumber!
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile
set wildmenu
set wildmode=list:longest,full

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=5

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" --- airline ---
" always display the status line
" https://vim.fandom.com/wiki/Displaying_status_line_always
set laststatus=2

" the mode is displayed by the status line
set noshowmode

" set the theme
" https://github.com/vim-airline/vim-airline/wiki/Screenshots
let g:airline_theme='papercolor'

" Fix symbols for airline
" https://vi.stackexchange.com/a/3360
let g:airline_powerline_fonts = 1

" --- NERDTree ---
" Source:
"     https://github.com/itscram/dotvim/blob/master/vimrc
"
" Split
"   o .. open in full window
"   i .. horizontal split
"   s .. vertical split
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

" Show Nerdtree
map <leader>n :NERDTreeToggle<cr>
"map <silent> <C-n> :NERDTreeToggle<CR>

" --- fzf mappings
nmap <Leader>f :Files<CR>
nmap <Leader>l :Lines<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>a :Ag<Space>

" --- TabNine
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
