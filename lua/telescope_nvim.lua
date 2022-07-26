local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then
  print("telescope failed to load.")
  return
end

telescope.setup({
  defaults = {
    file_ignore_patterns = { "build" }
  }
})

-- Load dap features
telescope.load_extension('dap')
telescope.load_extension('ui-select')

-- Mappings for telescope
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)
