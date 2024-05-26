-- Keymaps to make terminal mode a bit more bearable
vim.keymap.set('t', [[<C-\>]], [[<C-\><C-n>]])
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])

local minifiles_toggle = function(...)
  if not MiniFiles.close() then MiniFiles.open(...) end
end
vim.keymap.set('n', '<leader>e', minifiles_toggle, { noremap = true, silent = true, desc = "Open file browser" })
vim.keymap.set('n', '<leader>pf', MiniPick.builtin.files, { noremap = true, silent = true, desc = 'Search files'})
vim.keymap.set('n', '<leader>pg', MiniPick.builtin.grep_live, { noremap = true, silent = true, desc = 'Search text' })
vim.keymap.set('n', '<leader>ph', MiniPick.builtin.help, { noremap = true, silent = true, desc = 'Search help tags' })
vim.keymap.set('n', '<leader>pb', MiniPick.builtin.buffers, { noremap = true, silent = true, desc = 'Search buffers' })
