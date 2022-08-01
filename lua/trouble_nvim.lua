local ok, trouble = pcall(require, 'trouble')
if not ok then
  print('trouble failed to load')
  return
end

-- Mappings
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble<cr>', opts)
vim.keymap.set('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist<cr>', opts)
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', opts)
vim.keymap.set('n', 'gR', '<cmd>Trouble lsp_references<cr>', opts)

-- Config
trouble.setup({
  -- Using default config
})
