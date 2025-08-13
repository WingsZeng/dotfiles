return {
  "folke/flash.nvim",
  specs = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.mappings.n["<M-f>"] = { function() require("flash").jump() end, desc = "Flash jump" }
      opts.mappings.o["<M-f>"] = opts.mappings.n["<M-f>"]
      opts.mappings.x["<M-f>"] = opts.mappings.n["<M-f>"]
      opts.mappings.n["<M-S-F>"] = { function() require("flash").treesitter() end, desc = "Flash treesitter" }
      opts.mappings.o["<M-S-F>"] = opts.mappings.n["<M-S-F>"]
      opts.mappings.x["<M-S-F>"] = opts.mappings.n["<M-S-F>"]
    end,
  },
  opts = {
    labels = "asdfjkl",
    search = {
      multi_window = false,
    },
    label = {
      uppercase = false,
      rainbow = {
        enabled = true,
        shade = 5,
      },
    },
    modes = {
      char = {
        enabled = false,
        keys = {},
      },
    },
    highlight = {
      backdrop = false,
    },
    prompt = {
      enabled = false,
    },
  },
}
