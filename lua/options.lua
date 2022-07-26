local options = {
  background = "dark",            -- dark background for gruvbox theme
  colorcolumn = "80,120",         -- draw lines on column 80 and 120 to standardize line length
  expandtab = true,               -- Expand tab characters into spaces
  guifont = "FiraCode Nerd Font", -- Name(s) of font(s) to be used
  ignorecase = true,              -- ignore case in search patterns
  number = true,                  -- print the line number in front of each line
  shiftwidth = 4,                 -- number of spaces to use for (auto)indent
  smartcase = true,               -- no ignore case when pattern has uppercase
  smartindent = true,             -- smart autoindenting for C programs
--  splitbelow = true,              -- new window from split is below the current one
  splitright = true,              -- new window from vsplit is right of the current one
  syntax = true,
  tabstop = 4,                    -- number of spaces that <Tab> in file uses
  termguicolors = true,           -- enables 24-bit RGB color in the TUI
  wrap = false                    -- long lines wrap and continue on the next line
}

-- Change leader key from \ to <space>
vim.g['mapleader'] = ' '

for k, v in pairs(options) do
  vim.o[k] = v
end

-- No automatic comment continuation for these files
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "css",
    command = "set formatoptions-=cro"
  }
)

-- Tab size 2 for these files
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = { "lua", "css", "tex" },
    command = "set shiftwidth=2 tabstop=2"
  }
)

-- Set colorscheme
vim.cmd([[colorscheme gruvbox]])

-- Set completion settings
vim.opt.completeopt:append({"menuone", "noselect"})
