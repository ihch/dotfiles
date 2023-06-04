-- install lazy.nvim
-- {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- }}}

-- configs

local treesitter_config = function()
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            "comment", "css", "dockerfile", "fish",
            "git_config", "gitattributes", "gitcommit", "gitignore",
            "go", "html", "javascript", "json5", "lua", "markdown",
            "make", "prisma", "python", "rust", "scss", "sql",
            "toml", "tsx", "typescript", "yaml",
        },
        auto_install = true,
        highlight = {
            enable = true,
        },
        -- matchup = {
        --     enable = true,
        -- },
        autotag = {
            enable = true,
        },
    })
end


-- setup
require("lazy").setup({
    { "folke/tokyonight.nvim", lazy = false },
    { "sainnhe/edge", lazy = false },
    { "shaunsingh/nord.nvim", lazy = false },
    { "EdenEast/nightfox.nvim", lazy = false },
    { "nvim-lua/plenary.nvim" },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = treesitter_config,
        event = 'BufRead',
    },
    { "lewis6991/gitsigns.nvim", event = 'CursorHold' },
    -- { "andymass/vim-matchup", event = 'InsertEnter' },
    { "cohama/lexima.vim", event = 'InsertEnter' },
    { "windwp/nvim-ts-autotag" },
    { "sidebar-nvim/sidebar.nvim" },
    { "phaazon/hop.nvim", event = 'CursorHold' },
    { "akinsho/toggleterm.nvim", version = '*', config = true, event = 'CursorHold' },
    { "numToStr/Comment.nvim", event = 'VeryLazy'},
    { "norcalli/nvim-colorizer.lua", event = 'VeryLazy'},
    { "xiyaowong/transparent.nvim", event = 'VeryLazy' },

    -- LSP
    { "neovim/nvim-lspconfig" },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        event = { "BufReadPre", "VimEnter" },
    },
    { "williamboman/mason-lspconfig.nvim", event = "BufReadPre" },
    {
        "hrsh7th/nvim-cmp",
        event = 'VimEnter',
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-emoji" },
            { "onsails/lspkind.nvim" },
        },
    },

    -- denops familly
    { "vim-denops/denops.vim" },
    { "skanehira/denops-translate.vim", event = 'VeryLazy' },
})


-- vim config
vim.cmd [[
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
    " nnoremap <C-b> <C-d>
    nnoremap gr gT
]]


-- keymapping
vim.keymap.set('i', 'jj', '<ESC>', { silent = true, noremap = true })
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})
vim.keymap.set('n', '<leader>s',  require('sidebar-nvim').toggle, {})
vim.keymap.set('n', '<leader>t', '<cmd>Translate<CR>')
vim.keymap.set('v', '<leader>t', '<cmd>Translate<CR>')
vim.keymap.set('n', '<leader>T', '<cmd>Translate!<CR>')
vim.keymap.set('v', '<leader>T', '<cmd>Translate!<CR>')
vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', {})
vim.keymap.set('v', '<C-_>', '<Plug>(comment_toggle_blockwise_visual)', {})
vim.keymap.set('n', 'f', ':HopWordCurrentLine<CR>', {})
vim.keymap.set('n', 'F', ':HopWord<CR>', {})
vim.keymap.set('n', '<C-l>', '<cmd>exe v:count1 . "ToggleTerm"<CR>', {})
vim.keymap.set("n", "<C-g>", "<cmd>lua tig_toggle()<CR>", { noremap = true, silent = true })
vim.cmd [[
    nnoremap <silent> <space>e <cmd>lua vim.diagnostic.open_float()<CR>
    nnoremap <silent> <C-[> <cmd>lua vim.diagnostic.goto_prev()<CR>
    nnoremap <silent> <C-]> <cmd>lua vim.diagnostic.goto_next()<CR>
    nnoremap <silent> <space>q <cmd>lua vim.diagnostic.setloclist()<CR>
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
    nnoremap <silent> <space>a <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <space>f <cmd>lua vim.lsp.buf.formatting()<CR>
]]


-- insert {{{
require('Comment').setup()
local comment_api = require('Comment.api')
-- }}}


-- ui {{{
--[[ vim.cmd [[
    " augroup TransparentBG
    "     autocmd!
    "     autocmd Colorscheme * highlight Normal ctermbg=none
    "     autocmd Colorscheme * highlight NonText ctermbg=none
    "     autocmd Colorscheme * highlight LineNr ctermbg=none
    "     autocmd Colorscheme * highlight Folded ctermbg=none
    "     autocmd Colorscheme * highlight EndOfBuffer ctermbg=none 
    "     autocmd Colorscheme * highlight SignColumn ctermbg=none 
    " augroup END

    " autocmd Colorscheme * highlight Normal      ctermbg=none guibg=none
    " autocmd Colorscheme * highlight NonText     ctermbg=none guibg=none
    " autocmd Colorscheme * highlight LineNr      ctermbg=none guibg=none
    " autocmd Colorscheme * highlight Folded      ctermbg=none guibg=none
    " autocmd Colorscheme * highlight EndOfBuffer ctermbg=none guibg=none
    " autocmd Colorscheme * highlight SignColumn  ctermbg=none guibg=none
]]

--[[ vim.api.nvim_create_autocmd("Colorscheme", {
    pattern = "*",
    callback = function() 
        vim.api.nvim_set_hl(0, "Normal",        { cterbg=none })
        vim.api.nvim_set_hl(0, "NonText",       { cterbg=none })
        vim.api.nvim_set_hl(0, "LineNr",        { cterbg=none })
        vim.api.nvim_set_hl(0, "Folded",        { cterbg=none })
        vim.api.nvim_set_hl(0, "EndOfBuffer",   { cterbg=none })
        vim.api.nvim_set_hl(0, "SignColumn",    { cterbg=none })
    end
}) ]]

vim.cmd('colorscheme nightfox')
require('gitsigns').setup()
require('sidebar-nvim').setup({ open = true })
require('colorizer').setup()
require("transparent").setup({
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
  },
  extra_groups = {}, -- table: additional groups that should be cleared
  exclude_groups = {}, -- table: groups you don't want to clear
})
vim.cmd('TransparentEnable')


-- move {{{
local hop = require('hop')
local directions = require('hop.hint').HintDirection
hop.setup()
-- }}}


-- terminal {{{
require('toggleterm').setup()
local terminal = require('toggleterm.terminal').Terminal

local tig_window = terminal:new({
	cmd = "tig",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "single"
	},
	hidden = true
})

function tig_toggle()
	tig_window:toggle()
end
-- }}}


-- LSP {{{
local mason = require('mason')
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local servers = {
    "denols",
    "tsserver",
    "eslint",
    "jsonls",
    "gopls",
    "rust_analyzer",
    "html",
    "lua_ls",
}

mason_lspconfig.setup({
    ensure_installed = servers
})

cmp.setup({
    mapping = cmp.mapping.preset.insert(),
    sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 100 },
        { name = 'emoji', priority = 50, insert = true },
    }, {
        { name = 'buffer' },
    }),
    formatting = {
        format = require('lspkind').cmp_format({
            with_text = true,
            menu = {
                buffer = "[A]",
                nvim_lsp = "[LSP]",
                emoji = "[emoji]"
            },
        })
    },
})

local setup_servers = {
    -- "denols",
    -- "tsserver",
    -- "eslint",
    "jsonls",
    "gopls",
    "rust_analyzer",
    "html",
}

lspconfig.tsserver.setup({
    capabilities = capabilities,
    -- filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "typescript.tsx" },
    root_dir = lspconfig.util.root_pattern("package.json"),
})
lspconfig.eslint.setup({
    capabilities = capabilities,
    -- filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "typescript.tsx" }
})
lspconfig.denols.setup({
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("deno.json"),
})

for _, lsp in pairs(setup_servers) do
    require('lspconfig')[lsp].setup {
        capabilities = capabilities,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }
end
-- }}}


-- TODO nerdfontを検討する
-- TODO folke/todo-comments.nvim

-- MEMO 参考にした
--      https://zenn.dev/yutakatay/articles/neovim-plugins-2022
--      https://github.com/Shougo/shougo-s-github
--      https://github.com/skanehira/dotfiles
