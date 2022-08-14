local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      })
      vim.api.nvim_command("packadd packer.nvim")
    end
    vim.api.nvim_create_autocmd("BufWritePost plugins.lua",
      { pattern = "plugins.lua", command = "source <afile> | PackerCompile" })
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Load only when required
    use {
      "nvim-lua/plenary.nvim",
      module = "plenary",
    }

    -- Colorscheme
    use {
      "ellisonleao/gruvbox.nvim",
      config = function()
        vim.api.nvim_command("colorscheme gruvbox")
      end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Git
    use {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
      end,
    }
    use {
      "kdheepak/lazygit.nvim",
      config = function()
        require("config.lazygit").setup()
      end,
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indentblankline").setup()
      end,
    }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({ default = true })
      end,
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
    }

    -- Better comments
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    }

    -- Give information about current file in statusline
    use {
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("config.lualine").setup()
      end,
    }

    -- Display current context given by lsp
    use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig",
      config = function()
        require("nvim-navic").setup()
      end,
    }

    -- Fuzzy finder
    use {
      "junegunn/fzf",
      run = "./install --all",
      event = "BufEnter",
    }
    use {
      "ibhagwan/fzf-lua",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
    }

    -- Better completion
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "ray-x/cmp-treesitter"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-calc"
    use "f3fora/cmp-spell"
    use "hrsh7th/cmp-emoji"
    use "rafamadriz/friendly-snippets"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lsp"
    use {
      "hrsh7th/nvim-cmp",
      wants = { "LuaSnip" },
      config = function()
        require("config.nvim_cmp").setup()
      end,
    }
    use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      config = function()
        require("config.luasnip").setup()
      end,
    }

    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      wants = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("config.autopairs").setup()
      end,
    }
    use {
      "RRethy/nvim-treesitter-endwise",
      wants = "nvim-treesitter",
    }

    -- Auto tag
    use {
      "windwp/nvim-ts-autotag",
      wants = "nvim-treesitter",
      config = function()
        require("nvim-ts-autotag").setup({ enable = true })
      end
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      wants = { "nvim-lsp-installer" },
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "williamboman/nvim-lsp-installer",
        -- "ray-x/lsp_signature.nvim", -- lsp_signature causing st to crash for some reason
      },
    }

    if packer_bootstrap then
      print("Restart required after installation.")
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require("packer")
  packer.init(conf)
  packer.startup(plugins)
end

return M
