return {
  "danymat/neogen",
  lazy = true,
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<C-S-/>"] = {
            function() require('neogen').generate({}) end,
            desc = "Generate annotation",
          },
        },
        i = {
          ["<C-S-/>"] = {
            function() require('neogen').generate({}) end,
            desc = "Generate annotation",
          },
        },
      },
    },
  },
  config = true,
}
