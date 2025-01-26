-- Default config
vim.lsp.config("*", {
  root_markers = { ".git" },
})

-- Enable servers configured in lsp/<server_name>.lua
vim.lsp.enable("clangd")
vim.lsp.enable("css_lsp")
vim.lsp.enable("lua_ls")
vim.lsp.enable("superhtml")
