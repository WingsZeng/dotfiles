return {
  "stevearc/aerial.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>lS"] = false,
          ["<C-s>"] = { function() require("aerial").toggle { focus = false } end, desc = "Symbols outline" },
        },
      },
    },
  },
  opts = {
    layout = {
      placement = "window",
      resize_to_content = false,
    },
  },
}
