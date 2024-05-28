require('mini.deps').setup({})
require('mini.comment').setup({})
require('mini.pairs').setup({})

require('mini.pick').setup({})
local minifiles_toggle = function(...)
  if not MiniFiles.close() then MiniFiles.open(...) end
end
vim.keymap.set('n', '<leader>e', minifiles_toggle, { noremap = true, silent = true, desc = "Open file browser" })
vim.keymap.set('n', '<leader>pf', MiniPick.builtin.files, { noremap = true, silent = true, desc = 'Search files'})
vim.keymap.set('n', '<leader>pg', MiniPick.builtin.grep_live, { noremap = true, silent = true, desc = 'Search text' })
vim.keymap.set('n', '<leader>ph', MiniPick.builtin.help, { noremap = true, silent = true, desc = 'Search help tags' })
vim.keymap.set('n', '<leader>pb', MiniPick.builtin.buffers, { noremap = true, silent = true, desc = 'Search buffers' })

require('mini.completion').setup({
  lsp_completion = {
    source_func = 'omnifunc',
    auto_setup = false
  }
})

require('mini.files').setup({})
-- Toggle hidden files mini.files
local show_dotfiles = true
local filter_show = function(_) return true end
local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, '.')
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
  end,
})

require('plugins')
