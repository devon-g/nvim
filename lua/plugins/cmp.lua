return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
  },
  opts = function(_, opts)
    local cmp = require("cmp");

    -- Use neovim builtin snippets
    if not opts.snippet then
      opts.snippet = {}
    end

    opts.snippet.expand = function(args)
      vim.snippet.expand(args.body)
    end

    -- Configure mappings
    if not opts.mapping then
      opts.mapping = {}
    end

    opts.mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    })

    -- Completion sources
    if not opts.sources then
      opts.sources = {}
    end

    opts.sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "vsnip" },
    }, {
      { name = "buffer" },
    })
  end,
}
