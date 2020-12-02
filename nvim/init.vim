if &compatible
  set nocompatible               " Be iMproved
endif
if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
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
" syntax enable

if dein#check_install()
  call dein#install()
endif
endif
" }}}

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
set laststatus=0

" clipboard 共有
set clipboard=unnamed

" key mapping {{{
inoremap jj <ESC>
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-b> <C-d>
nnoremap gr gT
" nnoremap <C-i> :tabnew<CR>:Tig<CR>
" }}}

" {{{ colorscheme
" colorscheme hybrid
" colorscheme neodark
" }}}

" {{{ autocmd filetiye
autocmd BufRead,BufNewFile *.ts set filetype=typescript
autocmd BufRead,BufNewFile *.tsx set filetype=typescript.tsx
" autocmd FileType vue set foldmethod=indent foldlevel=5
"}}}

" detect python path
let g:python_host_prog = '/Users/nemu_sou/.myenv/bin/python'
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

fun! FzfOmniChangeFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles?
  endif
endfun
 
" nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Rg<Space>
" nnoremap <leader><leader> :Commands<CR>
nnoremap <C-f> :call FzfOmniFiles()<CR>
nnoremap <C-s> :call FzfOmniChangeFiles()<CR>
" command! -bang -nargs=* Rg
" \ call fzf#vim#grep(
" \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
" \ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
" \ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
" \ <bang>0)
" }}}

" "基本的にこれだけでOK
" lua require'nvim_lsp'.tsserver.setup{}
" 
" "omnifuncを設定
" autocmd Filetype typescript setlocal omnifunc=v:lua.vim.lsp.omnifunc
" 
" "lsp.txtそのまま
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>

let g:session_path = '/Users/ihachihiro/Projects/vsession'

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <C-[> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-]> <Plug>(coc-diagnostic-next)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)<CR>
nmap <leader>f  <Plug>(coc-format-selected)<CR>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)<CR>
nmap <leader>a  <Plug>(coc-codeaction-selected)<CR>

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Disabled `set number` when i open the terminal
autocmd TermOpen * setlocal nonumber norelativenumber
