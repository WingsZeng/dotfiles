return {
  "zbirenbaum/copilot-cmp",
  dependencies = {
    {
      "zbirenbaum/copilot.lua",
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
      },
    },
    {
      "onsails/lspkind.nvim",
      opts = {
        symbol_map = {
          Copilot = "",
        },
      },
    },
  },
  opts = {},
  specs = {
    {
      "hrsh7th/nvim-cmp",
      optional = true,
      opts = function(_, opts) table.insert(opts.sources, { name = "copilot", priority = 1200 }) end,
    },
  },
}
