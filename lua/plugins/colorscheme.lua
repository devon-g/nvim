return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_command("colorscheme catppuccin")
    end,
  },
  "nvim-tree/nvim-web-devicons",
}
