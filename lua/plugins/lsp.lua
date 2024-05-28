MiniDeps.add('williamboman/mason.nvim')
MiniDeps.add('williamboman/mason-lspconfig.nvim')
MiniDeps.add('neovim/nvim-lspconfig')
MiniDeps.add('folke/neodev.nvim')

local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

mason.setup({})
mason_lspconfig.setup({
  ensure_installed = { 'lua_ls' }
})

mason_lspconfig.setup_handlers({
  -- Default handler
  function(server)
    lspconfig[server].setup({})
  end,
  -- Specific handlers
  ["lua_ls"] = function() -- Requires special setup for nvim configs
    require('neodev').setup({})
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })
  end,
  ['rust_analyzer'] = function()
    lspconfig.rust_analyzer.setup({
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            allTargets = false,
          },
        },
      },
    })
  end,
  ['jdtls'] = function()
    lspconfig.jdtls.setup({
      cmd = {
        'jdtls',
        '-configuration',
        tostring(vim.fn.getenv('HOME')) .. '/.cache/jdtls/config',
        '-data',
        tostring(vim.fn.getenv('HOME')) .. '/.cache/jdtls/workspace',
        '--jvm-arg=-javaagent:'
          .. require('mason-registry').get_package('jdtls'):get_install_path()
          .. '/lombok.jar',
      },
    })
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
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
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)

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
