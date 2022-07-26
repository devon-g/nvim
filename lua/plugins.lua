local packer_ok, packer = pcall(require, 'packer')
if not packer_ok then
  return
end

local use = packer.use
-- Configure packer
packer.startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- Configurations for nvim lsp
  use 'ellisonleao/gruvbox.nvim' -- Gruvbox theme
  use { -- Syntax highlighting
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use { -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'BurntSushi/ripgrep' }
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
  use { -- Virtual text support for dap and treesitter
    'theHamsta/nvim-dap-virtual-text',
    requires = {
      { 'nvim-treesitter/nvim-treesitter' },
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
