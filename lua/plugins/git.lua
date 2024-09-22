require('mini.git').setup({})

MiniDeps.add('lewis6991/gitsigns.nvim')
require('gitsigns').setup({})

MiniDeps.add('f-person/git-blame.nvim')
require('gitblame').setup({
  enabled = false,
})
