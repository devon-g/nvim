-- {{{ Bootstrap mini.nvim
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
-- }}}

-- {{{ Configure UI
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
-- }}}

-- {{{ Enable random mini libs that are one liners
later(function()
  require('mini.pick').setup({})
  require('mini.comment').setup({})
  require('mini.pairs').setup({})
end)
-- }}}

-- {{{ Configure mini.files browser
later(function()
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
end)
-- }}}

-- {{{ Mason, lspconfig, and nvim.completion
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

  -- {{{ LSP server configs
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
  -- }}}

  -- {{{ LSP Keymaps
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
  -- }}}
end)
-- }}}

-- {{{ Load user config
later(function()
  require('autocmd')
  require('options')
  require('keymaps')
end)
-- }}}

-- vim: foldmethod=marker foldlevel=0
