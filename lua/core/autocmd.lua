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

local lsp_augroup = vim.api.nvim_create_augroup("my.lsp", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_augroup,
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local opts = { buffer = args.buf, noremap = true, silent = true }

    -- DEFAULT GLOBAL LSP KEYMAPS
    --   grn  | vim.lsp.buf.rename()
    --   gra  | vim.lsp.buf.code_action()
    --   grr  | vim.lsp.buf.references()
    --   gri  | vim.lsp.buf.implementation()
    --   gO   | vim.lsp.buf.document_symbol()
    -- CTRL-S | vim.lsp.buf.signature_help()
    --   gq   | formatexpr=vim.lsp.formatexpr()
    --   K    | vim.lsp.buf.hover()

    opts.desc = "Toggle diagnostic virtual_lines"
    vim.keymap.set("n", "gK", function()
      local new_config = not vim.diagnostic.config().virtual_lines
      vim.diagnostic.config({ virtual_lines = new_config })
    end, opts)

    opts.desc = "Show line diagnostics"
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    if client:supports_method("textDocument/declaration") then
      opts.desc = "Go to declaration"
      vim.keymap.set("n", "grd", vim.lsp.buf.declaration, opts)
    end

    if client:supports_method("textDocument/definition") then
      opts.desc = "Go to type definitions"
      vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, opts)
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    -- Auto-format on save
    if not client:supports_method("textDocument/willSaveWaitUntil")
        and client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_augroup,
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
