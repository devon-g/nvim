-- Keymaps to make terminal mode a bit more bearable
vim.keymap.set('t', [[<C-\>]], [[<C-\><C-n>]])
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])

local minifiles_toggle = function(...)
  if not MiniFiles.close() then MiniFiles.open(...) end
end
vim.keymap.set('n', '<leader>e', minifiles_toggle, { noremap = true, silent = true })
