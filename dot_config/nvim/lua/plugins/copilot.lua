return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      ["*"] = true,
    },
  },
  specs = {
    {
      "Saghen/blink.cmp",
      optional = true,
      specs = {
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
                max_compeletitions = 3,
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
