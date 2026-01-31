-- lsp config
-- plugins/lsp.lua

return {
  -- Mason core
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- Mason <-> LSP bridge (installs + can auto-enable)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "jedi_language_server",
        "cssls",
        "bashls",
        "jsonls",
        "yamlls",
        "lua_ls",
      },

      -- We'll explicitly enable servers ourselves (below),
      -- so turn off mason-lspconfig's automatic enabling.
      automatic_enable = false,
    },
  },

  -- Server configs live in nvim-lspconfig, but setup() is deprecated.
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- LSP capabilities (optionally extended by cmp-nvim-lsp)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- Keymaps + buffer-local attach behavior
      local on_attach = function(client, bufnr)
        -- disable semantic tokens if you don't like the highlights
        client.server_capabilities.semanticTokensProvider = nil

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "K", vim.lsp.buf.hover, "Hover info")
        map("n", "<leader>gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "<leader>gr", vim.lsp.buf.references, "Go to references")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, "Format file")
      end

      -- Server-specific configs (same idea as before, just no .setup())
      local servers = {
        jedi_language_server = {
          settings = {
            jedi = {
              completion = { resolveEagerly = true },
              diagnostics = { enable = true },
            },
          },
        },
        cssls = {},
        bashls = {},
        jsonls = {},
        yamlls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
      }

      -- Define/extend configs with vim.lsp.config()
      for name, cfg in pairs(servers) do
        cfg.capabilities = capabilities
        cfg.on_attach = on_attach
        vim.lsp.config(name, cfg)
      end

      -- Enable them so they attach to their filetypes
      -- (In newer 0.11.x, enabling will also attach to already-open buffers.)
      vim.lsp.enable(vim.tbl_keys(servers))
    end,
  },
}
