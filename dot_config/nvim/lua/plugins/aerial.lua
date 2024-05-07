return {
  "stevearc/aerial.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>lS"] = false,
          ["<C-o>"] = { function() require("aerial").toggle() end, desc = "Symbols outline" },
        },
      },
    },
  },
}
