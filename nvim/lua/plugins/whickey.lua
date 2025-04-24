-- whichkey config
-- plugins/whichkey.lua

return {
    {
        'folke/which-key.nvim',
        event = 'VimEnter',
        config = function()
            require('which-key').setup()

            -- Document existing chains
            require('which-key').add {
                { '<leader>c', group = '[C]ode' },
                { '<leader>d', group = '[D]ocument' },
                { '<leader>m', group = '[M]acros', mode = { 'n' } },
                { '<leader>g', group = '[G]o To' },
                { '<leader>s', group = '[S]earch' },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>w', group = '[W]orkspace' },
            }
        end,
    },
}
