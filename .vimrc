" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

syntax enable
" colorscheme badwolf

"save automaticly when run external command
set autowrite

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent		" always set autoindenting on
set smartindent
"set expandtab
" all tab stuff to 4
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cinoptions=>4
set expandtab		"otherwise source code looks differntly depending on viewer

set nobackup		" do not keep a backup file, use versions instead
set viminfo='50,\"500
set history=50		" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching
set confirm			" ask instead of error message
set showmatch		"control if right bracket match, if not beep
set ruler
set rulerformat=set rulerformat=%-35(%4l,%02c\ %07P%)\ \ %f\ %< "show position of cursor
set clipboard=unnamed	"copy into clipboard yanked lines (choosen with y)

" highlight current line
set cul
set cursorline

"automatic completition of commands
set wildchar=<Tab>
set wildmenu
set wildmode=longest:full,full

" Don't use Ex mode, use Q for formatting
map Q gq
map <F2> :w<CR>
map <F3> [I
"map <F4> :TlistToggle<CR>
map <F5> :%!perltidy<CR>
map <F6> :!perl %<CR>
map <F8> :!perl -X %<CR>
map <F7> :resize +10<CR>
map <F9> :!perl -cW %<CR>
map <F12> :q!<CR>
imap <F2> <Esc>:w<CR>
imap <F3> <Esc>[I
imap <F6> <Esc>:!perl %<CR>
imap <F8> <Esc>:!perl -X %<CR>
imap <F7> <Esc>:resize +10<CR>
imap <F9> <Esc>:!perl -cW %<CR>
imap <F12> <Esc>:q!<CR>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  hi Comment ctermfg=cyan
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
"  filetype plugin indent on
    
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")
abbrev udu use Data::Dumper
"abbrev dump print Dumper(
abbrev pr print
