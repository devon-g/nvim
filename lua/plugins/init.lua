return {
  "folke/lazy.nvim",
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_command("colorscheme gruvbox")
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    config = true,
  },
  {
    "windwp/nvim-ts-autotag",
    config = true,
  }
}
