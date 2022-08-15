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
    local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
      packer_bootstrap = vim.fn.system({
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
        require("gruvbox").setup()
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

    -- Better comments
    use {
      "numToStr/Comment.nvim",
      keys = { "gc", "gcc", "gb", "gbc", "gcO", "gco", "gcA" },
      config = function()
        require("Comment").setup()
      end,
    }

    -- Better surround
    use {
      "kylechui/nvim-surround",
      event = "InsertEnter",
      config = function()
        require("nvim-surround").setup()
      end,
    }

    -- Give information about current file in statusline
    use {
      "nvim-lualine/lualine.nvim",
      after = "nvim-treesitter",
      config = function()
        require("config.lualine").setup()
      end,
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
      config = function()
        require("config.treesitter").setup()
      end,
    }

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      opt = true,
      cmd = { "Telescope" },
      module = "telescope",
      wants = {
        "plenary.nvim",
        "popup.nvim",
        "telescope-fzf-native.nvim",
        "telescope-project.nvim",
        "telescope-repo.nvim",
        "telescope-file-browser.nvim",
        "project.nvim",
      },
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", rune = "make" },
        "nvim-telescope/telescope-project.nvim",
        "cljoly/telescope-repo.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        {
          "ahmedkhalf/project.nvim",
          config = function()
            require("project_nvim").setup()
          end,
        },
      },
      config = function()
        require("config.telescope").setup()
      end,
    }

    -- Better completion
    use {
      "hrsh7th/nvim-cmp",
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        {
          "L3MON4D3/LuaSnip",
          wants = "friendly-snippets",
          config = function()
            require("config.luasnip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
      },
      config = function()
        require("config.nvim_cmp").setup()
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

    -- End wise
    use {
      "RRethy/nvim-treesitter-endwise",
      wants = "nvim-treesitter",
      event = "InsertEnter",
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      wants = { "nvim-lsp-installer", "lsp_signature.nvim" },
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "williamboman/nvim-lsp-installer",
        "ray-x/lsp_signature.nvim", -- lsp_signature causing st to crash for some reason
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
