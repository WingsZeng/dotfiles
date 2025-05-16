return {
  "danymat/neogen",
  lazy = true,
  specs = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local keymap = {
        function() require("neogen").generate {} end,
        desc = "Generate annotation",
      }
      opts.mappings["n"]["<C-S-/>"] = keymap
      opts.mappings["i"]["<C-S-/>"] = keymap
    end,
  },
  opts = {},
}
