local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
-- If treesitter failed to import, don't try do do any configurations
if not treesitter_ok then
  print('treesitter failed to load')
  return
end

-- Configure treesitter
treesitter.setup({
  -- Languages to highlight
  ensure_installed = 'all',
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }--,
--  indent = {
--    enable = true
--  }
})

-- Folding support
-- Workaround for treesitter + folds
--vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
--  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--  callback = function(command)
--    vim.opt.foldmethod = 'expr'
--    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--  end
--})
