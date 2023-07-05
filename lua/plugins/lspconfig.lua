return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", tag = "legacy" },
      "folke/neodev.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- Configure lsp servers
      local servers = {
        clangd = {}, -- C/C++
        cmake = {},  -- CMake
        cssls = {},  -- CSS
        html = {},   -- HTML
        lua_ls = {
                     -- Lua
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        pylsp = {},         -- Python
        rust_analyzer = {}, -- Rust
        tsserver = {},      -- Typescript
      }

      -- Show lsp init information on bottom left of editor
      require("fidget").setup()

      -- Manage lsp servers
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig       = require("lspconfig")

      -- Update client capabilities to include what nvim-cmp supports
      local capabilities    = vim.lsp.protocol.make_client_capabilities()
      capabilities          = require("cmp_nvim_lsp").default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Set up neovim custom lua support
      require("neodev").setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
      })

      -- Make sure configured servers are installed
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      -- Setup lsp servers based on configuration
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            settings = servers[server_name],
          })
        end,
      })
    end
  },
}
