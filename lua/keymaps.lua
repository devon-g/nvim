-- Keymaps to make terminal mode a bit more bearable
vim.keymap.set('t', [[<C-\>]], [[<C-\><C-n>]])
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])

-- Populate location list with TODO comments
vim.keymap.set('n', '<leader>td', function()
  vim.cmd('lvimgrep /TODO: /j **')
  vim.cmd('lopen')
end)
