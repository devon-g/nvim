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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local opts = { buffer = args.buf, noremap = true, silent = true }

    opts.desc = "Show line diagnostics"
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

    opts.desc = "Go to declaration"
    vim.keymap.set("n", "grd", vim.lsp.buf.declaration, opts)

    opts.desc = "Go to implementations"
    vim.keymap.set("n", "gri", vim.lsp.buf.implementation, opts)

    opts.desc = "Go to type definitions"
    vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, opts)
  end,
})
