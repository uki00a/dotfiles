set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8

if &compatible
  set nocompatible
endif

" options {{{
set noundofile
set noswapfile
set nobackup
set viminfo=
set number
set ruler
set showmatch
set showcmd
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set nocindent
set backspace=indent,eol,start
set hlsearch
set incsearch
set showmatch
set wildmenu
set formatoptions+=mM
set laststatus=2
set cmdheight=2
set showcmd
set title
set foldmethod=marker
set vb t_vb=
set novisualbell
set keywordprg=:help
set background=dark
set guioptions-=T
" options }}}

" global {{{
let g:mapleader = "\<Space>"
let g:vim_indent_cont = 2
" global }}}

augroup MyAutoCmd
  autocmd!
augroup END


" plugins {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repos_dir = expand(s:dein_dir . "/repos/github.com/Shougo/dein.vim")

execute "set runtimepath+=" . s:dein_repos_dir

if isdirectory(s:dein_repos_dir) && dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(fnamemodify(expand('<sfile>'), ':h') . '/dein.toml')

  let s:dein_local_dir = expand('~/.local/share/dein') 
  let s:dein_local_toml = s:dein_local_dir . '/dein.toml'

  if filereadable(s:dein_local_toml)
    call dein#load_toml(s:dein_local_toml)
  endif

  if isdirectory(s:dein_local_dir)
    call dein#local(s:dein_local_dir,
      \ { 'frozen': 1, 'merged': 0 },
      \ ['vim*', '*-vim', 'unite-*', 'denite-*', '*.vim'])
  endif
  
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
" plugins }}}

" newtw {{{
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_banner = 0
" netrw }}}

" augroups {{{
function! s:load_matchit()
  if !exists('g:loaded_matchit') | runtime! macros/matchit.vim | endif
endfunction

augroup JavaScript
  autocmd!
  autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

augroup Vimscript 
  autocmd!
  autocmd FileType vim setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType vim call s:load_matchit()
augroup END

augroup C
  autocmd!
  autocmd FileType c,cpp setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

augroup Python
  autocmd!
  autocmd FileType python setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END

augroup Ruby
  autocmd!
  autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType ruby call s:load_matchit()
augroup END

augroup CSharp
  autocmd!
  autocmd BufRead,BufNewFile *.cshtml set filetype=html
augroup END
" augroups }}}

" terminal {{{
if has('terminal')
  if exists('+termkey')
    set termkey=<C-_>
  endif

  if has('win32') || has('win64')
    set shell=powershell.exe
  endif
endif
" terminal }}}

" key mappings {{{
nnoremap [unite] <Nop>
nnoremap [vim-test] <Nop>

nmap <Leader>u [unite]
nmap <Leader>t [vim-test]

if exists(':Denite')
  nnoremap <silent> [unite]f :<C-u>Denite -buffer-name=files -mode=normal file/rec<CR>
  nnoremap <silent> [unite]b :<C-u>Denite buffer -mode=normal<CR>
  nnoremap <silent> [unite]t :<C-u>Denite deol -immediately -mode=normal<CR>
  nnoremap <silent> [unite]g :<C-u>Denite grep -no-quit<CR>
  nnoremap <silent> [unite]r :<C-u>Denite register -mode=normal -buffer-name=register<CR>
  nnoremap <silent> [unite]l :<C-u>DeniteCursorWord line -mode=normal -buffer-name=search<CR>
  nnoremap <silent> [unite]m :<C-u>Denite menu -mode=normal<CR>
  nnoremap <silent> [unite]c :<C-u>Denite command_history -mode=normal<CR>
else
  nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]t :<C-u>Unite -immediately tab:no-current<CR>
  nnoremap <silent> [unite]g :<C-u>Unite grep -no-quit<CR>
  nnoremap <silent> [unite]r :<C-u>Unite register -buffer-name=register<CR>
  nnoremap <silent> [unite]l :<C-u>UniteWithCursorWord line -buffer-name=search<CR>
  nnoremap <silent> [unite]m :<C-u>Unite menu<CR>
endif

nnoremap <silent> [vim-test]n :<C-u>TestNearest<CR>
nnoremap <silent> [vim-test]f :<C-u>TestFile<CR>
nnoremap <silent> [vim-test]s :<C-u>TestSuite<CR>
nnoremap <silent> [vim-test]l :<C-u>TestLast<CR>
nnoremap <silent> [vim-test]v :<C-u>TestVisit<CR>

inoremap <C-Space> <C-x><C-n>
inoremap <C-l> <C-x><C-o>

inoremap <C-N> <C-X><C-N>
" key mappings }}}
