return {
  "luozhiya/fittencode.nvim",
  event = "User AstroFile",
  dependencies = {
    "onsails/lspkind.nvim",
    opts = {
      symbol_map = {
        FittenCode = "󱨹",
      },
    },
  },
  opts = {
    completion_mode = "source",
  },
  specs = {
    {
      "hrsh7th/nvim-cmp",
      optional = true,
      opts = function(_, opts) table.insert(opts.sources, { name = "fittencode", priority = 1200 }) end,
    },
  },
}
