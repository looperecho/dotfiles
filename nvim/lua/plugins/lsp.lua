-- lsp config
-- plugins/lsp.lua

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            -- Mason
            require('mason').setup()
            require('mason-lspconfig').setup {
                ensure_installed = {
                    "jedi_language_server", -- Python
                    "cssls",                -- CSS
                    "bashls",               -- Bash
                    "jsonls",               -- JSON
                    "yamlls",               -- YAML
                    "lua_ls",               -- Lua
                },
                automatic_installation = true,
            }

            local lspconfig = require('lspconfig')

            -- LSP capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
            if has_cmp then
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            end

            -- Keymaps
            local on_attach = function(client, bufnr)
                client.server_capabilities.semanticTokensProvider = nil
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end
                map('n', 'K', vim.lsp.buf.hover, "Hover info")
                map('n', '<leader>gd', vim.lsp.buf.definition, "Go to definition")
                map('n', '<leader>gr', vim.lsp.buf.references, "Go to references")
                map('n', '<leader>rn', vim.lsp.buf.rename, "Rename symbol")
                map('n', '<leader>ca', vim.lsp.buf.code_action, "Code action")
                map('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, "Format file")
            end

            -- Server-specific configs
            local servers = {
                -- Python
                jedi_language_server = {
                    settings = {
                        jedi = {
                            completion = {
                                resolveEagerly = true,
                            },
                            diagnostics = {
                                enable = true,
                            },
                        },
                    },
                },
                cssls = {},
                bashls = {},
                jsonls = {},
                yamlls = {},
                -- Lua
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = { globals = { 'vim' } },
                            workspace = { checkThirdParty = false },
                        },
                    },
                },
            }

            for server, config in pairs(servers) do
                config.on_attach = on_attach
                config.capabilities = capabilities
                lspconfig[server].setup(config)
            end
        end,
    },
}
