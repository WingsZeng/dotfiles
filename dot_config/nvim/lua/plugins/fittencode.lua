return {
  "luozhiya/fittencode.nvim",
  dependencies = {
    "onsails/lspkind.nvim",
    opts = {
      symbol_map = {
        FittenCode = "󱨹",
      },
    },
  },
  opts = {
    completion_mode = 'source',
    disable_specific_inline_completion = {
      suffixes = { "copilot-chat" },
    },
  },
}
