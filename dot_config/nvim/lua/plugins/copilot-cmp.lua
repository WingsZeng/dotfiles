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
}
