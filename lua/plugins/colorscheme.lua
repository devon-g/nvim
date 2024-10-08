return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_command("colorscheme gruvbox")
    end,
  },
  "nvim-tree/nvim-web-devicons",
}
