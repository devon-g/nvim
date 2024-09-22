MiniDeps.add('williamboman/mason-lspconfig.nvim')
MiniDeps.add('neovim/nvim-lspconfig')
MiniDeps.add('folke/neodev.nvim')

local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

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
