return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "ibhagwan/fzf-lua", -- Required for lsp keybinds
    "folke/neodev.nvim", -- Simple neovim dev configs for lua_ls
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- Mason plugins must be set up before neovim's lspconfig
    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = { "lua_ls" },
    })

    -- SET UP LSP SERVERS
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    mason_lspconfig.setup_handlers({
      -- Default handler
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      -- Specific handlers
      ["lua_ls"] = function() -- Requires special setup for nvim configs
        require("neodev").setup({})
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        })
      end,
    })

    -- SET UP LSP KEYBINDS
    local fzf_lua = require("fzf-lua")
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local opts = { buffer = args.buf, noremap = true, silent = true }

        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gR", fzf_lua.lsp_references, opts)

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", fzf_lua.lsp_definitions, opts)

        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gi", fzf_lua.lsp_implementations, opts)

        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gt", fzf_lua.lsp_typedefs, opts)

        opts.desc = "Show LSP code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", fzf_lua.lsp_code_actions, opts)

        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>D", fzf_lua.diagnostics_document, opts)

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end,
    })
  end,
}
