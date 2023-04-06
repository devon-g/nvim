return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
            "folke/neodev.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            -- Pre lspconfig required things
            require("fidget").setup()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "clangd", "rust_analyzer" },
            })

            ---- Lspconfig stuffs
            local lspconfig = require("lspconfig")

            -- Update capabilities to include what nvim-cmp supports
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Set up lua lsp support
            -- Add neovim support to lua ls
            require("neodev").setup()
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                    }
                }
            })

            -- Configure clangd lsp
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })

            -- Configure rust lsp
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
            })
        end
    },
}
