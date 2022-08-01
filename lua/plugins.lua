local packer_ok, packer = pcall(require, 'packer')
if not packer_ok then
  print("packer failed to load.")
  return
end

local use = packer.use
-- Configure packer
packer.startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'ellisonleao/gruvbox.nvim' -- Gruvbox theme


  -- LSP Stuff
  use 'neovim/nvim-lspconfig' -- Configurations for nvim lsp
  use 'williamboman/mason.nvim' -- LSP and DAP manager
  use { -- Bridge LSPCONFIG and MASON.NVIM
    'williamboman/mason-lspconfig.nvim',
    requires = {
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' }
    }
  }
  use { -- Auto completion
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' }
    }
  }
  use 'mfussenegger/nvim-jdtls' -- Java lsp and more


  -- Pretty stuff
  use 'folke/lsp-colors.nvim' -- Automatically create missing colors from theme
  use 'kyazdani42/nvim-web-devicons' -- Icons 
  use { -- Syntax highlighting
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use { -- Virtual text support for dap and treesitter
    'theHamsta/nvim-dap-virtual-text',
    requires = {
      { 'nvim-treesitter/nvim-treesitter' },
      { 'mfussenegger/nvim-dap' }
    }
  }


  -- Utilities
  use 'windwp/nvim-autopairs' -- Automatically pair symbols and also wrap words with parentheses
  use 'folke/trouble.nvim' -- Collects warnings, errors, etc to one window
  use 'jose-elias-alvarez/null-ls.nvim' -- Styling and syntax checking

  use { -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'BurntSushi/ripgrep' }
    }
  }

  use { -- Use telescope for ui selection prompts
    'nvim-telescope/telescope-ui-select.nvim',
    requires = { 'nvim-telescope/telescope.nvim' }
  }

  use { -- Debugger tool with UI
    'rcarriga/nvim-dap-ui',
    requires = { 'mfussenegger/nvim-dap' }
  }

  use { -- Debugger tool telescope integration
    'nvim-telescope/telescope-dap.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'mfussenegger/nvim-dap' }
    }
  }
  use { -- CMake tools
    'Shatur/neovim-cmake',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'mfussenegger/nvim-dap' }
    }
  }
end)
