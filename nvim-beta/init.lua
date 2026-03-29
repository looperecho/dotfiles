-- nvim 12 config

require('keybinds')

-- set title
vim.o.title = true
vim.o.titlestring = "Neovim - %{expand('%:t')}"

-- Sync clipboard
vim.opt.clipboard = 'unnamedplus'

-- Lines
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 12
vim.opt.cursorline = true

-- Tab indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true

-- Faster vim
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- Incremental search highlighting
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Disable swap
vim.opt.swapfile = false
vim.opt.backup = false

-- new plugin manager
vim.pack.add { 
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/HoNamDuong/hybrid.nvim',
	'https://github.com/stevearc/oil.nvim'
}

-- colorscheme
vim.cmd.colorscheme('hybrid')
vim.g.have_nerd_font = true 
vim.opt.termguicolors = true
require('hybrid').setup({
    transparent = true,
})

-- LSP
vim.lsp.enable('basedpyright')

-- File Browsing
require('oil').setup({
    columns = {
        { 'mtime', highlight = 'NonText' },
    },
    delete_to_trash = true,
    view_options = {
        show_hidden = true
    },
    float = {
        max_width = 0.9,
        max_height = 0.9,
        preview_split = 'right'
    },
})
