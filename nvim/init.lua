-- neovim entry point
-- ~/.config/init.lua

-- load leymaps
require("system.keymaps")

-- load lazy
require("system.lazy")

-- set title
vim.o.title = true
vim.o.titlestring = "Neovim - %{expand('%:t')}"

-- theme
vim.cmd.colorscheme("hybrid")

-- enable nerdfont
vim.g.have_nerd_font = true

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Cursor line indicator
vim.opt.cursorline = true

-- Tab indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true

-- Incremental search highlighting
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Sync clipboard
vim.opt.clipboard = 'unnamedplus'

-- Faster vim
vim.opt.updatetime = 50

-- Display which-key faster
vim.opt.timeoutlen = 300

-- Scrolloff
vim.opt.scrolloff = 12

-- Good colors
vim.opt.termguicolors = true

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
