return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "zbirenbaum/copilot-cmp",   lazy = true },
    { "luozhiya/fittencode.nvim", lazy = true },
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.mapping["<C-U>"] = nil
    opts.mapping["<C-D>"] = nil
    opts.mapping["<C-E>"] = nil
    opts.mapping["<C-K>"] = nil
    opts.mapping["<C-J>"] = nil
    opts.mapping["<M-Space>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end
    )
    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      elseif vim.snippet and vim.snippet.active { direction = 1 } then
        vim.schedule(function() vim.snippet.jump(1) end)
      else
        fallback()
      end
    end, { "i", "s" })
    opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
      elseif vim.snippet and vim.snippet.active { direction = -1 } then
        vim.schedule(function() vim.snippet.jump(-1) end)
      else
        fallback()
      end
    end, { "i", "s" })

    if not opts.sources then opts.sources = {} end
    table.insert(opts.sources, { name = "copilot", priority = 1200 })
    table.insert(opts.sources, { name = "fittencode", priority = 1200 })
  end,
}
