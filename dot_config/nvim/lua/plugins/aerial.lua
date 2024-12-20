return {
  "stevearc/aerial.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>lS"] = false,
          ["<C-O>"] = { function() require("aerial").toggle({ focus = false }) end, desc = "Symbols outline" },
        },
      },
    },
  },
}
