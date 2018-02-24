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
" options }}}

" global {{{
let g:mapleader = "\<Space>"
let g:vim_indent_cont = 2
" global }}}

" plugins {{{
function! BuildVimProc()
  if has('win32') || has('win64')
    !tools\\update-dll-mingw
  elseif has('win32unix') 
    !make -f make_cygwin.mak
  elseif executable('gmake')
    !gmake
  else
    !make
  endif
endfunction

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repos_dir = expand(s:dein_dir . "/repos/github.com/Shougo/dein.vim")

execute "set runtimepath+=" . s:dein_repos_dir

call dein#begin(s:dein_dir)
call dein#add(s:dein_repos_dir)
call dein#add('Shougo/vimproc.vim', {
  \ 'hook_post_update': function('BuildVimProc'),
  \ 'on_source': ['unite.vim', 'vimshell.vim'] })
call dein#add('Shougo/unite.vim', { 'on_cmd': 'Unite' })
call dein#add('Shougo/vimshell.vim', {
  \ 'on_cmd': ['VimShell', 'VimShellTab', 'VimShellExecute', 'VimShellInteractive'],
  \ 'depends': 'vimproc.vim' })
call dein#add('pangloss/vim-javascript', { 'on_ft': 'javascript' })
call dein#add('mxw/vim-jsx', { 'on_ft': 'javascript.jsx' })
call dein#add('cocopon/iceberg.vim')

if isdirectory(expand('~/dein_local'))
  call dein#local(expand('~/dein_local'),
    \ { 'frozen': 1, 'merged': 0 },
    \ ['vim*', 'unite-*', 'denite-*', '*.vim'])
endif

call dein#end()

filetype plugin indent on
syntax enable
" plugins }}}

" newtw {{{
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_banner = 0
" netrw }}}

" vimshell {{{
" Use current directory as vimshell prompt.
let g:vimshell_prompt_expr =
\ 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '
" vimshell }}}

" filetypes {{{
augroup JavaScript
  autocmd!
  autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

augroup Vimscript 
  autocmd!
  autocmd FileType vim setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

augroup C
  autocmd!
  autocmd FileType c,cpp setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END
" filetypes }}}

" key mappings {{{
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]t :<C-u>Unite -immediately tab:no-current<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep -no-quit<CR>
inoremap <C-Space> <C-x><C-n>
inoremap <C-l> <C-x><C-o>

inoremap <C-N> <C-X><C-N>
vmap <silent> <Leader>s :VimShellSendString<CR>
" key mappings }}}
