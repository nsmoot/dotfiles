"" appearance / misc
set ruler
set encoding=utf-8
set fileencoding=utf-8
set showmatch
set showmode
set t_Co=256
syntax on
colorscheme desert
" set number

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

au FileType ruby set ts=2 sw=2 tw=79 et sts=2 autoindent
au FileType yaml set ts=2 sw=2 et
au FileType python set ts=2 sw=2 tw=79 et sts=2 autoindent
au FileType javascript,html,perl,c,cpp set tw=79 autoindent
au FileType mail set tw=68 et spell spelllang=en_us

