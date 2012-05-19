" Eric's vim configuration
" (c) Eric Foley <ericdfoley@gmail.com>
"
" I found many useful tips at:
"   http://sontek.net/turning-vim-into-a-modern-python-ide
"   http://nvie.com/posts/how-i-boosted-my-vim/

set nocompatible

" Change leader from \ to ,
" let mapleader=","

" Load pathogen to start
" filetype off " thought this was necessary...doesn't seem to be the case
call pathogen#infect()
" call pathogen#helptags() " only needs to be done after new bundles installed

filetype plugin indent on

" general
set hidden                " hide buffers instead of closing them
set number                " always number lines
set showmatch             " show matching parens
set title                 " set terminal title
" set visualbell            " no beeping!
set noerrorbells          " no beeping!
set nowrap                      " don't wrap lines
set backspace=indent,eol,start  " allow backspace over everything
set pastetoggle=<F2>            " paste mode turns off smart indent, etc.

" a trick for sudo when you write a file
" just do 'w!!' to write via sudo
cmap w!! w !sudo tee % >/dev/null

" make e.g. ';w' equivalent to ':w'
nnoremap ; : 

" make vertical navigation go to next row in editor as opposed to next line
" (useful on long wrapped lines)
nnoremap j gj
nnoremap k gk

" a bunch of indentation-related stuff...
set tabstop=2
set shiftwidth=2
set softtabstop=2 " TODO EDF what does this do??
set expandtab
set shiftround    " use multiple of shiftwidth when indenting w/ '<' or '>'
set smarttab      " insert tabs at beginning of line based on shiftwidth instead of tabstop

" search stuff...
" search like Eclipse Ctrl-J w/ smart case and highlighting
set ignorecase    " ignore case when searching
set smartcase     " case-insensitive when search term is all lowercase; case-sensitive otherwise
set hlsearch
set incsearch
nmap <silent> ,/ :nohlsearch<CR>

" command history, etc
set history=1000      " make history bigger!
set undolevels=1000

" opening & finding files
set wildignore=*.swp,*.bak,*.pyc,*.pyo,*.class " NOTE don't have spaces around commas!
set wildmode=list:longest " shell-style tab auto-completion for file paths

" get rid of backup & swap files
set nobackup
set noswapfile

" filetype specific settings
" autocmd filetype python set expandtab " sets expandtab only for python files

" use the mustang colorscheme
if $COLORTERM == 'gnome-terminal'
  " for some reason vim doesn't properly discover that the gnome-terminal
  " supports 256 colors
  set t_Co=256
endif
colorscheme mustang
if &t_Co >= 256 || has("gui_running")
  colorscheme mustang
endif

if &t_Co > 2 || has("gui_running")
  " switch syntax highlighting on, when the terminal has colors
  syntax on
endif


" toggle mouse between VIM and terminal
"   - focus on VIM allows for scroll
"   - focus on term allows for e.g. copy to clipboard
" copied from http://nvie.com/posts/how-i-boosted-my-vim/
fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "Mouse is for terminal"
    endif
endfunction
noremap <F12> :call <SID>ToggleMouse()<CR>


