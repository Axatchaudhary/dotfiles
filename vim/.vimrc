set nocompatible

call plug#begin('~/.vim/plugged')
" all essential settings
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'

"" Snippets and abbreviations
Plug 'mattn/emmet-vim', {'for': ['html', 'css']} " Expand abbreviations
Plug 'honza/vim-snippets'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'Shougo/neocomplete.vim', {'for': 'go'}

"" Writing/editing helpers
Plug 'tpope/vim-commentary' " Commenting helper
Plug 'tpope/vim-surround' " Simplified quoting and parenthesizing
Plug 'tpope/vim-abolish' " Search for, substitute, and abbreviate words
Plug 'tpope/vim-repeat' " repeat some of tpope plugins with '.'

Plug 'junegunn/goyo.vim' " Distraction free writing
" Plug 'junegunn/limelight.vim' " Hyperfocus writing
Plug 'junegunn/vim-easy-align'

" Visual
Plug 'itchyny/lightline.vim' " Pretty status line
Plug 'nathanaelkane/vim-indent-guides', {'on': 'IndentGuidesToggle'}
" Plug 'vim-airline/vim-airline'
" Misc
Plug 'ConradIrwin/vim-bracketed-paste'  " Automatic `:set paste`
Plug 'Raimondi/delimitMate' " Auto complete quotes, parens, brackets, etc
Plug 'tpope/vim-unimpaired' " Handy bracket mappings
Plug 'terryma/vim-multiple-cursors' " Sublime style multiple selections

" Languages
Plug 'python-mode/python-mode', { 'branch': 'develop' }

" Color schemes
Plug 'dracula/vim', { 'as': 'dracula' }

" Indent
Plug 'Yggdroot/indentLine'

" File explorer
Plug 'scrooloose/nerdtree'
call plug#end()


" Essentials -----------------------------------------------------------------
" Create vimrc autocmd group and remove any existing vimrc autocmds,
" in case .vimrc is re-sourced.
augroup vimrc
	autocmd!
augroup END


" Keep clutter under one roof-------------------------------------------
set backupdir=~/.vim/backup " Centralize backups
set directory=~/.vim/swap " Centralize swaps

if exists("&undodir") " Keen undo history in one place
	set undodir=~/.vim/undo
endif

" But don’t create backups when editing files in certain directories



" Persistent Undo-------------------------------------------------------
" Keep undo history across sessions, by storing in file.
" Only works all the time!
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif




" Looks-----------------------------------------------------------------
" Many useful defaults are covered in tpop/vim-sensible plugin. This file has
" been edited to avoid redundancy while keeping desired overrides

" This needs to be before selecting gruvbox colorscheme to ensure italics are
" displayed correctly
" let g:gruvbox_italic=1
let base16colorspace=256  " Access colors present in 256 colorspace

set background=dark
set t_Co=256 " Use 256 colors

try  " Don't use a color scheme if not found
 colorscheme base16-monokai
catch /^Vim\%((\a\+)\)\=:E185/
endtry


set noshowmode " Don't show the mode you're in. Vim-airline has your back
set number " Show line numbers
set relativenumber " Use relative line numbers

" Indents
let g:indentLine_char = '|'

" Show absolute numbers in insert mode, otherwise relative
autocmd vimrc InsertEnter * :set norelativenumber
autocmd vimrc InsertLeave * :set relativenumber



" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

set title " Show the filename in the window titlebar
" set cursorline " Highlight current line
set nowrap " Don't wrap lines by default


" Essentials------------------------------------------------------------
set linespace=0 " No extra spaces between rows
" set spell " Show spelling mistakes by default
set hidden " Allow switching buffers without saving
set report=0 " Show all changes
set clipboard=unnamed " Make yanks go to OS clipboard
set esckeys " Allow cursor keys in insert mode
set ttyfast " Optimize for fast terminal connections
let mapleader=","     " Change default backslash mapleader. Easier to type
set autochdir " Auto switch to current file's directory on opening new buffer
set lazyredraw " Don't force redraw when updating buffers

" Ignore some files in tab completion
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/node_modules/*
set wildignore+=*.gem
set wildignore+=*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/log/*,*/tmp/*

" Mouse and scrolling in terminal---------------------------------------
set mouse=a " Enable mouse and touchpad
" Start scrolling three lines before the horizontal window border
" This option overrides vim-sensible
set scrolloff=3
" Start scrolling three lines before the vertical window border
" This option overrides vim-sensible
set sidescrolloff=3



" Indentation-----------------------------------------------------------
set expandtab " Expand tabs into spaces
set smarttab " <Tab> inserts and <Bs> deletes shiftwidth places at line start
" set tabstop=2 " Make tabs as wide as two spaces
" set shiftwidth=2 " Apply the same for autoindent
" set softtabstop=2 " <TAB> and <BS> key results in 2 spaces as well



" Fomatting-------------------------------------------------------------
set textwidth=79 " Make it obvious where 79 character width is. red line
set colorcolumn= " Highlight column at textwidth
" Automatically insert comment leader after 'o' or 'O' in Normal mode.
" set fo+=o
" Only insert single space after a '.', '?' and '!' with a join command.
set nojoinspaces



" Code folding----------------------------------------------------------
set foldmethod=indent " Fold based on indent
set foldnestmax=3 " Deepest fold level
set nofoldenable " Don't fold by default



" Search and/or Replace-------------------------------------------------
set gdefault " Add the g (global) flag to search/replace by default
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set smartcase " Override if pattern has only uppercase letters
map <silent> <leader>/ <Esc>:nohlsearch<CR> " Clear last search



" Allow per-file configurations-----------------------------------------
" Respect modeline in files so files can have their own vim options
set modeline
set modelines=4

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure



" Disable unwanted behaviour--------------------------------------------
set binary
set noeol
set noerrorbells " Disable error bells. I can notice visual bells.
set nostartofline " Don’t reset cursor to start of line when moving around.
set shortmess=atI " Disable startup message
set gcr=a:blinkon0 " Disable cursor blinking



" Custom shortcuts for moving around buffers----------------------------
map <leader><leader> :b#<CR> " Switch between the last two files with ,,
map gb :bnext<CR> " Next buffer
map gB :bprev<CR> " Previous one



" Jump to buffer number 1-9 with ,<N> or 1-99 with <N>gb
let c = 1
while c <= 99
  if c < 10
    execute "nnoremap <silent> <leader>" . c . " :" . c . "b<CR>"
  endif
  execute "nnoremap <silent> " . c . "gb :" . c . "b<CR>"
  let c += 1
endwhile



" File type specific specs----------------------------------------------
" Use LaTeX rather than plain TeX.
let g:tex_flavor = "latex"

" vim
autocmd vimrc BufRead .vimrc,*.vim set keywordprg=:help

" Vimprovments----------------------------------------------------------
" Move more naturally up/down when wrapping is enabled.
nnoremap j gj
nnoremap k gk

" Use jk (and the other default <C-[>) to go to the normal mode
inoremap jk <ESC>

" Toggle folding with <Space>
nnoremap <Space> za
vnoremap <Space> za

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>



" New mappings for page up and down
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>

noremap <leader>W :w !sudo tee % > /dev/null<CR> " Save a file as root (,W)

" When editing a file, always jump to the last known cursor position, except
" for commit messages, invalid position, or when inside an event
" handler (happens when dropping a file on gvim).
autocmd vimrc BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" After search and replace, go back to where you started (with confirmation)
noremap ;; :%s:::g<Left><Left><Left>
noremap ;' :%s:::cg<Left><Left><Left><Left>

" Search and replace word under the cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)



" windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>w <C-W>
tnoremap <C-J> <C-\><C-n><C-W>ji
tnoremap <C-K> <C-\><C-n><C-W>ki
" tnoremap <C-L> <C-\><C-n><C-W>l
tnoremap <C-H> <C-\><C-n><C-w>hi
" Open new split panes to right and bottom
set splitbelow
set splitright


let g:pymode_python = 'python3'

nmap <silent> <buffer> gK <Plug>(kite-docs)