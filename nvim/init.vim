if &compatible
  set nocompatible
endif

if exists('g:vscode')
    " VSCode extension
else
" ordinary neovim
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

  call dein#load_toml(s:toml_dir . '/themes.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/ddc.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/ddu.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/utils.toml', {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif
endif

let mapleader="\<Space>"

"** ペーストするときにインデントさせない **
inoremap <F5> <nop>
set pastetoggle=<F5>

set noswapfile                      "swpの作成無効化
set nobackup                        "~の作成無効化
set writebackup                     "上書き成功時に~を削除
"set clipboard=unnamed ,autoselect  "クリップボードを共有
set infercase
set autoread
set clipboard=unnamed

"** 文字コード設定 **
set encoding=utf-8                  "vim
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp "保存するファイル
set fencs=utf-8,iso-2022-jp,enc-jp,cp932  "開くファイル

" 表示系
" set title
" set cursorline
" set cursorcolumn
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
" set foldmethod=indent

" buffer
set hidden
" set laststatus=0

" clipboard 共有
set clipboard=unnamed

colorscheme neodark

" key mapping
inoremap jj <ESC>
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-b> <C-d>
nnoremap gr gT

" set runtimepat^=~/Projects/ddu-source-git-status
" let g:denops#debug = 1

nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <space>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent> <space>wr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <silent> <space>wl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <silent> <space>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <space>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <space>f <cmd>lua vim.lsp.buf.formatting()<CR>
