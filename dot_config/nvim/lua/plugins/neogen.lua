return {
  "danymat/neogen",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<C-S-/>"] = { function() require('neogen').generate({}) end, desc = "Generate annotation"}
        maps.i["<C-S-/>"] = { function() require('neogen').generate({}) end, desc = "Generate annotation"}
      end,
    }
  },
  config = true,
}
