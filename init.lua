local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
end

require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Set colorscheme
now(function()
  add('sainnhe/gruvbox-material')
  vim.cmd('colorscheme gruvbox-material')
end)

-- Use special icons
now(function()
  add('nvim-tree/nvim-web-devicons')
  require('nvim-web-devicons').setup({})
end)

-- Enable random mini libs that are one liners
later(function()
  require('mini.pick').setup({})
  require('mini.comment').setup({})
  require('mini.pairs').setup({})
  require('mini.files').setup({})
end)

later(function()
end)

-- Configure mason, lspconfig, and nvim.completion
later(function()
  add('williamboman/mason.nvim')
  add('williamboman/mason-lspconfig.nvim')
  add('neovim/nvim-lspconfig')
  add('folke/neodev.nvim')

  require('mini.completion').setup({
    lsp_completion = {
      source_func = 'omnifunc',
      auto_setup = false
    }
  })

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
end)

later(function()
  require('autocmd')
  require('options')
  require('keymaps')
end)
