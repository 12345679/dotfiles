syntax on 

set number
set encoding=utf-8
set fileformat=unix
set backupdir=~/.backups/vim
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap
filetype off
filetype off 

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim
  call neobundle#rc(expand('~/.vim/.bundle'))
endif

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimprock'

filetype plugin on
filetype indent on
