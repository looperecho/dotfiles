-- Add indentation guides even on blank lines
-- plugins/indent-blank.lua

return {
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {
            indent = {
                char = "▏"
            },
            scope = {
                show_start = false,
                show_end = false,
            },
        },
    },
}
