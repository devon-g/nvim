local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print("Installing packer close and reopen Neovim  ... ")
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float {}
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use {
    "wbthomason/packer.nvim",  -- Have packer manage itself
    "nvim-lua/popup.nvim",         -- An implementation of the popup API from vim in Neovim
    "nvim-lua/plenary.nvim",       -- Useful lua functions used by lots of plugins
    "windwp/nvim-autopairs", -- Autopairs, integrats with both cmp and treesitter
    "numToStr/Comment.nvim", -- Easily comment stuff
  }

  -- Cholorschemes
  use {
    "ellisonleao/gruvbox.nvim",
  }

  -- cmp plugins
  use {
    "hrsh7th/nvim-cmp",         -- completion plugin
    "hrsh7th/cmp-nvim-lsp",     -- nvim lsp support
    "hrsh7th/cmp-nvim-lua",     -- nvim lua support
    "hrsh7th/cmp-buffer",       -- buffer completions
    "hrsh7th/cmp-path",         -- path completions
    "hrsh7th/cmp-cmdline",      -- cmdline completions
    "saadparwaiz1/cmp_luasnip", -- snippet completions
  }

  -- snippets
  use {
    "L3MON4D3/LuaSnip",              -- snippet engine
    "rafamadriz/friendly-snippets",  -- bunch of snippets to use
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",           -- enable LSP
    "williamboman/nvim-lsp-installer", -- simple to use language server installer
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",  -- Fuzzy searching
    "nvim-telescope/telescope-media-files.nvim",
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
  }

  -- Javascript support
  use {
    "pangloss/vim-javascript",
    "mxw/vim-jsx",
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
