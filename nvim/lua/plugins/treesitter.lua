return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "python", "bash", "json", "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "css", "yaml", "toml" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    }
}
