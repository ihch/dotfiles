if &compatible
  set nocompatible               " Be iMproved
endif

" {{{ dein
let s:dein_dir = expand('~/.config/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml_dir = s:dein_dir . '/../toml'

if !isdirectory(s:dein_repo_dir)
  echo 'install dein'
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

set runtimepath^=s:dein_repo_dir
let &runtimepath = s:dein_repo_dir . ',' . &runtimepath

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/theme.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/util.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})
  call dein#load_toml(s:toml_dir . '/frontend.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
" }}}

" 表示系
set title
set cursorline
set cursorcolumn
set number
set nowrap

set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
set laststatus=2
set updatetime=300

" indent
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

" 折りたたみ
set foldmethod=marker

" buffer
set hidden

" clipboard 共有
set clipboard=unnamed

" key mapping {{{
inoremap jj <ESC>
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <C-t> :<C-u>tabnew<CR>
" }}}

" {{{ colorscheme
" colorscheme hybrid
colorscheme neodark
" }}}

" {{{ autocmd filetiye
autocmd BufRead,BufNewFile *.ts set filetype=typescript
autocmd BufRead,BufNewFile *.tsx set filetype=typescript.tsx
"}}}

" detect python path
let g:python3_host_prog = '~/.myenv/bin/python3'

" {{{ FZF
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun
 
" nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Rg<Space>
" nnoremap <leader><leader> :Commands<CR>
nnoremap <C-f> :call FzfOmniFiles()<CR>
" command! -bang -nargs=* Rg
" \ call fzf#vim#grep(
" \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
" \ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
" \ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
" \ <bang>0)
" }}}
