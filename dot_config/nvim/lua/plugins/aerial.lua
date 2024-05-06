return {
  "stevearc/aerial.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>lS"] = false
        maps.n["<C-o>"] = { function() require("aerial").toggle() end, desc = "Symbols outline" }
      end,
    },
  },
}
