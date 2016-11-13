"" this must be first
set nocompatible

"" file management
set hidden
set wildmode=list:longest

"" appearance / misc
set ruler
set encoding=utf-8
set fileencoding=utf-8
set showmatch
set showmode
set t_Co=256
syntax on
set background=dark
colorscheme n
set number
if exists('+colorcolumn')
  set colorcolumn=80
endif

"" search
set ignorecase
set smartcase " case-insensitive for all-lower patterns
set incsearch
set hlsearch

"" tabs / indentation
set spellfile=~/.vim/spell.add
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab  " use spaces instead of tab
set autoindent " copy previous line's indentation

"" abbreviations
map q :q<CR>

"" recoveries
silent !mkdir -p ~/.vim/{backup,swp}/
set backupdir=~/.vim/backup/
set directory=~/.vim/swp/

filetype plugin indent on

au FileType ruby set ts=2 sw=2 tw=79 et sts=2 autoindent
au FileType yaml set ts=2 sw=2 et
au FileType javascript,python set ts=4 sw=4 tw=79 et sts=4 autoindent
au FileType html,perl,c,cpp set tw=79 autoindent
au FileType mail set tw=68 et spell spelllang=en_us
au FileType gitcommit set tw=72 et spell spelllang=en_us
au BufRead,BufNewFile /usr/local/etc/nginx/* set ft=nginx

"" au BufWritePost *.py call Pyflakes()
"" au BufWritePost *.py call Pep8()

"" remove all trailing whitespace
au FileType html,py,scss autocmd BufWritePre <buffer> :%s/\s\+$//e
