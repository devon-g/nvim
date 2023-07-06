return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",

      "SirVer/ultisnips",
      "quangnguyen30192/cmp-nvim-ultisnips",

      "windwp/nvim-autopairs",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      local cmp = require("cmp")
      require("lsp_signature").setup()

      cmp.setup({
        snippet = {
          expand = function (args)
	    vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
	  ["<C-p>"] = cmp.mapping.select_prev_item(),
	  ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function (fallback)
	    if cmp.visible() then
	      cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function (fallback)
	    if cmp.visible() then
	      cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "ultisnips" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
	completion = { completeopt = "menu,menuone,noinsert" },
	experimental = { ghost_text = true },
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end
  }
}
