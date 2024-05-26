local term_augroup = vim.api.nvim_create_augroup("TolerableTerm", {})
-- Start terminal buffers in insert mode
vim.api.nvim_create_autocmd({ "TermOpen", "WinEnter" }, {
  group = term_augroup,
  pattern = "term://*",
  command = "startinsert",
})
-- Disable line numbers in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = term_augroup,
  command = "set nonumber norelativenumber",
})

-- Define lsp keymaps only when an lsp server is attached to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

    local opts = { buffer = args.buf, noremap = true, silent = true }
    opts.desc = "Show line diagnostics"
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

    opts.desc = "Go to declaration"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "List references"
    vim.keymap.set('n', 'gR', vim.lsp.buf.references, opts)

    opts.desc = "Rename"
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})
