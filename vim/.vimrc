set nocompatible

" Vundle
" ------------------------------------------------------------------------------

filetype off        " required by vundle - reenabled below
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-markdown'
Bundle 'scrooloose/nerdtree'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-unimpaired'
Bundle 'elzr/vim-json'
Bundle 'scrooloose/syntastic'
Bundle 'nathanaelkane/vim-indent-guides'

" Tabs & Spaces
" -------------------------------------------------------------------------------

set expandtab
set tabstop=4
set shiftwidth=2
set softtabstop=2

" toggle between tabs and spaces
function TabToggle()
  if &expandtab
    set shiftwidth=4
    set softtabstop=4
    set noexpandtab
  else
    set shiftwidth=2
    set softtabstop=2
    set expandtab
  endif
endfunction
nmap <F8> mz:execute TabToggle()<CR>'z

" useful function for ensuring tab & space properties are properly in sync
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

set listchars=tab:▸\ ,eol:¬

" state preservation
function! Preserve(command)
  let _s=@/
  let l = line(".")
  let c = col(".")

  execute a:command

  let @/=_s
  call cursor(l, c)
endfunction

nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

" Miscellaneous
" ------------------------------------------------------------------------------
set scrolloff=0
set nowrap
set number
set cursorline
set ruler
set laststatus=2
set autoindent
set splitbelow
set splitright
set mouse=a
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <leader>a :Ack
nmap <leader>A :Ack <C-R><C-W><CR>
colorscheme tim
syntax on
filetype plugin indent on
set linebreak
set guifont=Inconsolata\ 9
set nocursorline

" Status Line
" ------------------------------------------------------------------------------

"function! InsertStatuslineColor(mode)
"  if a:mode == 'i'
"    hi StatusLine ctermbg=darkgreen
"    hi StatusLineNC ctermbg=darkgreen
"  elseif a:mode == 'r'
"    hi StatusLine ctermbg=blue
"    hi statusLineNC ctermbg=blue
"  else
"    hi StatusLine ctermbg=darkgray
"    hi StatusLineNC ctermbg=darkgray
"  endif
"endfunction

"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi StatusLine ctermbg=darkgray

" Clipboard
vmap <C-c> "+yi

" Window Resizing
nmap <F9> :vertical resize -10<CR>
nmap <F10> :vertical resize +10<CR>

" NERDTree
" ------------------------------------------------------------------------------

nmap <C-f> :NERDTreeToggle<CR>
let NERDTreeShowHidden=0
let NERDTreeChDirMode=2
let g:NERDTreeWinSize = 70

" Filetype autocommands
" ------------------------------------------------------------------------------

autocmd FileType ruby
  \ setlocal tabstop=2 |
  \ setlocal softtabstop=2 |
  \ setlocal shiftwidth=2

autocmd FileType python,css,javascript
  \ setlocal tabstop=4 |
  \ setlocal softtabstop=4 |
  \ setlocal shiftwidth=4

autocmd FileType makefile,Makefile,java,c,xml,html
  \ setlocal noexpandtab |
  \ setlocal tabstop=4 |
  \ setlocal softtabstop=4 |
  \ setlocal shiftwidth=4

" Movement
" ------------------------------------------------------------------------------

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Man Pages
" ------------------------------------------------------------------------------

runtime! ftplugin/man.vim
