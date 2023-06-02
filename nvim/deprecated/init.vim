if &compatible
  set nocompatible
endif

if exists('g:vscode')
    " VSCode extension
else
" ordinary neovim
let s:nvim_dir = expand('~/.config/nvim')
let s:toml_dir = s:nvim_dir . '/toml'
let s:dein_dir = s:nvim_dir . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  echo 'install dein'
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

set runtimepath^=s:dein_repo_dir
let &runtimepath = s:dein_repo_dir . ',' . &runtimepath

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " for startuptime
  call dein#add('nathom/filetype.nvim', { 'lazy': 0 })
  call dein#add('lewis6991/impatient.nvim', { 'lua_add': 'require("impatient")', 'lazy': 0 })

  call dein#load_toml(s:toml_dir . '/themes.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/nvim-cmp.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  " call dein#load_toml(s:toml_dir . '/ddc.toml', {'lazy': 0})
  " call dein#load_toml(s:toml_dir . '/coc.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/ddu.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/utils.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/terminal.toml', {'lazy': 1})
  call dein#load_toml(s:toml_dir . '/treesitter.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" filetype plugin indent on

if dein#check_install()
  call dein#install()
endif
endif

" {{{ 標準プラグインの無効化
" https://zenn.dev/kawarimidoll/articles/8172a4c29a6653
let g:did_install_default_menus = 1
let g:did_install_syntax_menu   = 1
let g:did_indent_on             = 1
" let g:did_load_filetypes        = 1
let g:did_load_ftplugin         = 1
let g:loaded_2html_plugin       = 1
let g:loaded_gzip               = 1
let g:loaded_man                = 1
let g:loaded_matchit            = 1
let g:loaded_matchparen         = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_remote_plugins     = 1
let g:loaded_shada_plugin       = 1
let g:loaded_spellfile_plugin   = 1
let g:loaded_tarPlugin          = 1
let g:loaded_tutor_mode_plugin  = 1
let g:loaded_zipPlugin          = 1
let g:skip_loading_mswin        = 1
" }}}

" colorscheme neodark

" let mapleader="\<Space>"
let mapleader="\<Space>"

"** ペーストするときにインデントさせない **
inoremap <F5> <nop>
set pastetoggle=<F5>

set noswapfile                      "swpの作成無効化
set nobackup                        "~の作成無効化
set writebackup                     "上書き成功時に~を削除
set infercase
set autoread

"** 文字コード設定 **
set encoding=utf-8                  "vim
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp "保存するファイル
set fencs=utf-8,iso-2022-jp,enc-jp,cp932  "開くファイル

" 表示系
" set title
" set cursorline
" set cursorcolumn
" set number
set relativenumber
set nowrap

set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
" set laststatus=2
set updatetime=300

" indent
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" 折りたたみ
set foldmethod=marker
" set foldmethod=indent

" buffer
set hidden
set laststatus=2

" clipboard 共有
set clipboard=unnamed
let g:clipboard = {
        \   'name': 'WslClipboard',
        \   'copy': {
        \      '+': 'win32yank.exe -i',
        \      '*': 'win32yank.exe -i',
        \    },
        \   'paste': {
        \      '+': 'win32yank.exe -o',
        \      '*': 'win32yank.exe -o',
        \   },
        \   'cache_enabled': 1,
        \ }

" key mapping
inoremap jj <ESC>
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-b> <C-d>
nnoremap gr gT

" set runtimepath^=~/Projects/mtnf.vim
" let g:denops#debug = 1

