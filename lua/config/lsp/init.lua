local M = {}

local servers = {
  bashls = {}, -- Bash
  clangd = {}, -- C/C++
  cmake = {}, -- CMake
  hls = {}, -- Haskell
  html = {}, -- HTML
  jsonls = {}, -- JSON
  lemminx = {}, -- XML
  pyright = {}, -- Python
  sumneko_lua = {}, -- Lua
  yamlls = {}, -- YAML
}

-- local status_ok, lsp_signature = pcall(require, "lsp_signature")
-- if not status_ok then
--   return
-- end
--
-- lsp_signature.setup({
--   bind = true,
--   handler_opts = {
--     border = "rounded",
--   },
-- })

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr
  -- See `:help formatexpr` for more information
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  require("config.lsp.keymaps").setup(client, bufnr)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
}

function M.setup()
  require("config.lsp.installer").setup(servers, opts)
end

return M
