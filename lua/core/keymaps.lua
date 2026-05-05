-- Keymaps to make terminal mode a bit more bearable
vim.keymap.set("t", [[<C-\>]], [[<C-\><C-n>]])
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])

-- Snippets
vim.keymap.set({ 'i', 's' }, '<Tab>', function()
   if vim.snippet.active({ direction = 1 }) then
     return '<Cmd>lua vim.snippet.jump(1)<CR>'
   else
     return '<Tab>'
   end
 end, { expr = true })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
   if vim.snippet.active({ direction = -1 }) then
     return '<Cmd>lua vim.snippet.jump(-1)<CR>'
   end
 end, { expr = true })

local fzf_lua = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "Fuzzy find files" })
vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep,
  { desc = "Fuzzy find string" })
