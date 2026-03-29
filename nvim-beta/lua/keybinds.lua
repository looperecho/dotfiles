-- keybinds

-- leader key 
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- open Oil
vim.keymap.set('n', '<leader>e', ':Oil --float --preview<CR>')

-- ,ove selected
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- search cursor middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- almost autopairs
vim.keymap.set("i", '""', '""<Left>')
vim.keymap.set("i", "''", "''<Left>")
vim.keymap.set("i", "[]", "[]<Left>")
vim.keymap.set("i", "{}", "{}<Left>")
vim.keymap.set("i", "()", "()<Left>")

-- write as root
vim.cmd([[ cnoreabbrev w!! w !sudo tee % >/dev/null <Bar> echo "Authenticate..."]])

-- make file executable
vim.keymap.set("n", "<leader>dx", "<cmd>!chmod +x %<CR>", {silent=true, desc="Make Current File Executable"})
