" Eric's vim configuration
" (c) Eric Foley <ericdfoley@gmail.com>
"
" I found many useful tips at:
"   http://sontek.net/turning-vim-into-a-modern-python-ide
"   http://nvie.com/posts/how-i-boosted-my-vim/

set nocompatible

filetype off " required while we add vundle bundles
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" add bundles here!
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'lukerandall/haskellmode-vim'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'eagletmt/neco-ghc'

Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-leiningen'

call vundle#end()
filetype plugin indent on

" setup haskellmode-vim
let g:haddock_browser='chrome'
au BufEnter *.hs compiler ghc

" Change leader from \ to ,
" let mapleader=","

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

set background=dark
syntax enable             " use syntax highlighting
syntax on
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

" TODO EDF still need this stuff??
" set the colorscheme
if $COLORTERM == 'gnome-terminal'
  " for some reason vim doesn't properly discover that the gnome-terminal
  " supports 256 colors
  set t_Co=256
endif

"let g:solarized_termcolors = 256
"colorscheme solarized

if &t_Co >= 256 || has("gui_running")
  colorscheme mustang
  "colorscheme darkblue
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

" This should allow Esc to close the command-t search window
if &term =~ "xterm" || &term =~ "screen"
  let g:CommandTCancelMap = ['<ESC>', '<C-c>']
endif
