local term_augroup = vim.api.nvim_create_augroup("TolerableTerm", {})
-- Start terminal buffers in insert mode
vim.api.nvim_create_autocmd({ "TermOpen", "WinEnter" }, {
  group = term_augroup,
  pattern = "term://*",
  command = "startinsert",
})
-- Disable line numbers in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = term_augroup,
  command = "set nonumber norelativenumber",
})

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

-- Define lsp keymaps only when an lsp server is attached to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

    local opts = { buffer = args.buf, noremap = true, silent = true }

    opts.desc = 'Open float for diagnostics under cursor'
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

    opts.desc = 'Goto declaration of symbol'
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    opts.desc = 'Populate quickfix list with symbol references'
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    opts.desc = 'Smart rename symbol'
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    opts.desc = 'Goto implementation of symbol'
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    opts.desc = 'Display signature help in hover overlay'
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    opts.desc = 'Add folder to workspace'
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)

    opts.desc = 'Remove folder from workspace'
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)

    opts.desc = 'List workspace folders'
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    opts.desc = 'Goto symbol type definition'
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)

    opts.desc = 'Reformat buffer'
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async=true })
    end, opts)
  end,
})
