-- better syntax highlighting
-- plugins/treesitter.lua

return {
    {
        "nvim-treesitter/nvim-treesitter",
        name = "nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.config")
            configs.setup({
                ensure_installed = {
                    "lua",
                    "python",
                    "bash",
                    "c",
                    "vim",
                    "javascript",
                    "typescript",
                    "tsx",
                    "html",
                    "css",
                    "yaml",
                    "toml",
                },
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = { enable = true },
            })
        end,
    },
}
