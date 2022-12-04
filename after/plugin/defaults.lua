-- Remap leader and local leader to <Space>
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.background = "dark" -- Dark background if supported by colorscheme
vim.opt.clipboard = "unnamedplus" -- Access system clipboard
vim.opt.colorcolumn = "80,120" -- Draw verticle columns at text column 80 and 120
vim.opt.expandtab = true -- Expand tab characters into spaces
vim.opt.guifont = "FiraCode Nerd Font" -- Name(s) of font(s) to be used
vim.opt.ignorecase = true -- Case insensitive searching unless /C or capital in search
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.number = true -- Make line numbers default
vim.opt.shiftwidth = 4 -- Number of spaces to use for (auto)indent
vim.opt.showmode = false -- Hide modes on bottom line since we are using lualine
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.smartcase = true -- No ignore case when pattern has uppercase
vim.opt.smartindent = true -- Smart autoindenting for C programs
vim.opt.tabstop = 4 -- Number of spaces that <Tab> in file uses
vim.opt.termguicolors = true -- Enable colors in terminal
vim.opt.undofile = true -- Save undo history
vim.opt.wrap = false -- No line wrapping

-- Highlight on yank
local group = vim.api.nvim_create_augroup("YankHighlight", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
        vim.highlight.on_yank()
    end,
  pattern = "*",
  group = group
})

-- Folding options
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = -1
vim.opt.foldenable = true
