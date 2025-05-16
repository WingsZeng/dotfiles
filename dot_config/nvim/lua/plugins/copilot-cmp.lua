return {
  "zbirenbaum/copilot-cmp",
  event = "User AstroFile",
  opts = {},
  specs = {
    {
      "zbirenbaum/copilot.lua",
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
      },
    },
    {
      "Saghen/blink.cmp",
      optional = true,
      specs = {
        { "Saghen/blink.compat", version = "*", lazy = true, opts = {} },
        { "fang2hou/blink-copilot" },
      },
      opts = {
        sources = {
          default = { "copilot" },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              score_offset = 100,
              async = true,
              opts = {
                max_completitions = 3,
              },
            },
          },
        },
      },
    },
    {
      "onsails/lspkind.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.symbol_map then opts.symbol_map = {} end
        opts.symbol_map.Copilot = ""
      end,
    },
  },
}
