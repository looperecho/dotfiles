-- keybinds

-- leader key 
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- move selected
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


---- Leader Combos
-- open Oil
vim.keymap.set('n', '<leader>e', ':Oil --float --preview<CR>', {desc='Open Oil'})

-- make file executable
vim.keymap.set('n', '<leader>dx', '<cmd>!chmod +x %<CR>', {desc='Make Current File Executable'})

-- save as root
vim.keymap.set('n', '<leader>dw', function()
    local result = vim.system({ 'sudo', '-n', 'true' }):wait()

    if result.code ~= 0 then
        vim.notify('Authenticate...', vim.log.levels.INFO)
    end

    vim.cmd('write !sudo tee % >/dev/null')
    vim.cmd('edit!')
end, {
    desc = 'Write File As Root',
})


---- Completion navigation
-- next
vim.keymap.set('i', '<C-j>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-n>'
    end

    return '<C-j>'
end, {
    expr = true,
    silent = true,
})

-- previous
vim.keymap.set('i', '<C-k>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-p>'
    end

    return '<C-k>'
end, {
    expr = true,
    silent = true,
})

-- accept
vim.keymap.set('i', '<Tab>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-y>'
    end

    return '<Tab>'
end, {
    expr = true,
    silent = true,
    desc = 'Accept completion',
})

-- cancel
vim.keymap.set('i', '<Esc>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-e>'
    end

    return '<Esc>'
end, {
    expr = true,
    silent = true,
})
