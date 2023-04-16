return {
  {
    "lervag/vimtex",
    config = function()
      vim.api.nvim_command("filetype plugin on")
      vim.api.nvim_command("syntax enable")
      vim.g.vimtex_view_method = "zathura"
    end
  }
}
