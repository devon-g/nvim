local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path,
      })
      vim.api.nvim_command("packadd packer.nvim")
    end
    vim.api.nvim_create_autocmd("BufWritePost plugins.lua", { pattern = "plugins.lua", command = "source <afile> | PackerCompile" })
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Load only when required
    use { "nvim-lua/plenary.nvim", module = "plenary" }

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
      end
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("config.indentblankline").setup()
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
      end
    }

    -- Toggleterm
    use {
      "akinsho/toggleterm.nvim",
      config = function()
        require("config.toggleterm").setup()
      end
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
      "ibhagwan/fzf-lua",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
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
