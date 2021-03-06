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
set background=light
set guioptions-=T
" options }}}

" global {{{
let g:mapleader = "\<Space>"
let g:vim_indent_cont = 2
" global }}}

augroup MyAutoCmd
  autocmd!
  autocmd VimEnter * call dein#call_hook("post_source")
augroup END


" plugins {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repos_dir = expand(s:dein_dir . "/repos/github.com/Shougo/dein.vim")

execute "set runtimepath+=" . s:dein_repos_dir

if isdirectory(s:dein_repos_dir) && dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(fnamemodify(expand('<sfile>'), ':h') . '/dein.toml')
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

function! s:on_typescript() abort
  map <buffer> <C-]> <Plug>(lsp-definition)
  imap <buffer> <C-Space> <Plug>(asyncomplete_force_refresh) 
endfunction

function! s:on_golang() abort
  map <buffer> <C-]> <plug>(lsp-definition)
endfunction

function! s:on_rust() abort
  map <buffer> <C-]> <plug>(lsp-definition)
endfunction

function! s:on_lisp() abort
  imap <buffer> <C-Space> <Plug>(asyncomplete_force_refresh)
  call asyncomplete#enable_for_buffer()
endfunction

augroup JavaScript
  autocmd!
  autocmd FileType javascript :map <buffer> <C-]> <Plug>(ale_go_to_definition)
augroup END

augroup TypeScript
  autocmd!
  autocmd FileType typescript call s:on_typescript()
augroup END

augroup Vimscript 
  autocmd!
  autocmd FileType vim call s:load_matchit()
augroup END

augroup C
  autocmd!
augroup END

augroup Python
  autocmd!
  autocmd FileType python setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END

augroup Ruby
  autocmd!
  autocmd FileType ruby call s:load_matchit()
augroup END

augroup CSharp
  autocmd!
  autocmd BufRead,BufNewFile *.cshtml set filetype=html
  autocmd FileType cs setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END

augroup Golang
  autocmd!
  autocmd FileType go setlocal noexpandtab
  autocmd FileType go call s:on_golang()
augroup END

augroup Rust
  autocmd!
  autocmd FileType rust call s:on_rust()
augroup END

augroup CommonLisp
  autocmd!
  autocmd BufRead,BufNewFile *.asd set filetype=lisp
  autocmd FileType lisp call s:on_lisp()
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

" commands {{{
" command! -nargs=0 Ghq :call vimrc#fzf#ghq()
" command! -nargs=0 FzfDein :call vimrc#fzf#dein()
" commands }}}

" functions {{{
function! s:EnableLsp() abort
  call lsp#enable()
  echomsg "vim-lsp enabled"
endfunction
" functions }}}

" key mappings {{{
nnoremap [ff] <Nop>
nnoremap [git] <Nop>

nmap <Leader>f [ff]
nmap <Leader>g [git]
nmap <Leader>l [lsp]
nmap <Leader>a [ale]
nmap <Leader>s [shell]

" clap
nnoremap <silent> <C-u> :<C-u>Clap history<CR>
nnoremap <silent> [ff]f :<C-u>Clap history<CR>
nnoremap <silent> [ff]b :<C-u>Clap buffers<CR>
" TODO Use ag
nnoremap <silent> [ff]g :<C-u>Clap grep2<CR>
nnoremap <silent> [ff]l :<C-u>Clap lines<CR>
nnoremap <silent> [ff]c :<C-u>Clap command<CR>
nnoremap <silent> [ff]m :<C-u>Clap maps<CR>

" gina
nnoremap <silent> [git]b :<C-u>Gina branch --opener=split<CR>
nnoremap <silent> [git]s :<C-u>Gina status --opener=split<CR>
nnoremap <silent> [git]d :<C-u>Gina diff --opener=split<CR>
nnoremap <silent> [git]c :<C-u>Gina commit<CR>
nnoremap <silent> [git]p :<C-u>Gina push<CR>
nnoremap <silent> [git]l :<C-u>Gina log --opener=split<CR>

" vim-lsp
nmap <silent> [lsp]e :<C-u>call <SID>EnableLsp()<CR>
nmap <silent> [lsp]d :<C-u>call lsp#disable()<CR>
nmap <silent> [lsp]h <Plug>(lsp-hover)
nmap <silent> [lsp]r <Plug>(lsp-references)
nmap <silent> [lsp]f :<C-u>LspDocumentFormat<CR>
nmap <silent> [lsp]n :<C-u>LspNextDiagnostic<CR>
nmap <silent> [lsp]r :<C-u>LspRename<CR>

" deol
nnoremap <silent> [shell]o :<C-u>Deol zsh -split=vertical<CR>
nmap <silent> [shell]n <Plug>(deol_bg)

" fern.vim
nnoremap <C-b> :<C-u>Fern . -drawer -toggle<CR>

inoremap <C-Space> <C-x><C-o>
inoremap <C-n> <C-x><C-n>
imap <expr> <C-j> vsnip#expandable() ? "<Plug>(vsnip-expand)" : "<C-j>"
nnoremap <silent> <C-e> :<C-u>WinResizerStartResize<CR>
nnoremap <C-p> <PageUp>
nnoremap <C-n> <PageDown>

vnoremap <C-c> "+y
" key mappings }}}
