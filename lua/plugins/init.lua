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
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = ":call mkdp#util#install()",
  },
}
