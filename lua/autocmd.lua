local term_augroup = vim.api.nvim_create_augroup('TolerableTerm', {})
-- Start terminal buffers in insert mode
vim.api.nvim_create_autocmd({ 'TermOpen', 'WinEnter' }, {
  group = term_augroup,
  pattern = 'term://*',
  command = 'startinsert',
})
-- Disable line numbers in terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  group = term_augroup,
  command = 'set nonumber norelativenumber',
})

local lsp_augroup = vim.api.nvim_create_augroup('UserLspConfig', {})
-- Configure lsp to use MiniCompletion and set up some keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_augroup,
  callback = function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

    local opts = { buffer = args.buf, noremap = true, silent = true }

    opts.desc = 'Open float for diagnostics under cursor'
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

    opts.desc = 'Goto declaration of symbol'
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    opts.desc = 'Goto implementation of symbol'
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    opts.desc = 'Goto symbol type definition'
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)

    opts.desc = 'Reformat buffer'
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async=true })
    end, opts)
  end,
})
