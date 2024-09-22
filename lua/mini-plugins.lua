require('mini.deps').setup({})
require('mini.pairs').setup({})
require('mini.pick').setup({})
require('mini.completion').setup({
  -- Use completion on LspAttach instead of BufEnter
  lsp_completion = {
    source_func = 'omnifunc',
    auto_setup = false,
  }
})

vim.keymap.set('n', '<leader>pf', MiniPick.builtin.files, { noremap = true, silent = true, desc = 'Search files'})
vim.keymap.set('n', '<leader>pg', MiniPick.builtin.grep_live, { noremap = true, silent = true, desc = 'Search text' })
vim.keymap.set('n', '<leader>ph', MiniPick.builtin.help, { noremap = true, silent = true, desc = 'Search help tags' })
vim.keymap.set('n', '<leader>pb', MiniPick.builtin.buffers, { noremap = true, silent = true, desc = 'Search buffers' })

require('plugins')
