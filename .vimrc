" dein vim {{{
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル(後述)を用意しておく
  let g:rc_dir    = expand('~/.vim')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" }}}

imap ^[OA <Up>
imap ^[OB <Down>
imap ^[OC <Right>
imap ^[OD <Left>
set backspace=indent,eol,start "Backspaceを調整

"** 代わりにする **
"inoremap <C-j> <esc>
inoremap jj <esc>

"** ペーストするときにインデントさせない **
inoremap <F5> <nop>
set pastetoggle=<F5>

"** システム設定 **
set nocompatible
set noswapfile                      "swpの作成無効化
set nobackup                        "~の作成無効化
set writebackup                     "上書き成功時に~を削除
"set clipboard=unnamed,autoselect  "クリップボードを共有
set infercase
set autoread
set nowrap                          "折り返ししない

"** 折りたたみ **
set foldmethod=marker

"** 文字コード設定 **
set encoding=utf-8                  "vim
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp "保存するファイル
set fencs=utf-8,iso-2022-jp,enc-jp,cp932  "開くファイル

"** 表示設定 **
syntax enable                       "ハイライト表示
set title                           "タイトル
set number                          "行番号
set cursorline                      "カーソルラインの表示
set cursorcolumn
set list
set listchars=tab:»-,eol:¬,extends:»,precedes:«,nbsp:%
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
set laststatus=2
"let g:Powerline_symbols = 'fancy'
"set laststatus=2

"** カラースキーマ設定 **
set t_Co=256
set background=dark
"let g:solarized_termcolors=256
"colorscheme molokai
colorscheme hybrid
"colorscheme solarized
"let g:molokai_original=1

set tabstop=2                       "タブ文字幅
set shiftwidth=2                    "インデント幅
set expandtab                       "タブにスペースを使う
set smartindent
let g:python_highlight_all = 1
language en_US.UTF-8

"** ファイル別設定 **
filetype on
filetype plugin indent on
"autocmd BufNewFile *.cpp 0r $HOME/Dropbox/kurokoji/template/cpp.cpp
autocmd FileType html set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType c,cpp set cindent cinoptions+=:0,g0
