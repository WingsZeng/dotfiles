return {
  "folke/flash.nvim",
  layz = true,
  event = "User AstroFile",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        x = {
          ["f"] = {
            function() require("flash").jump() end,
            desc = "Flash",
          },
          ["F"] = {
            function() require("flash").treesitter() end,
            desc = "Flash Treesitter",
          },
        },
        o = {
          ["f"] = {
            function() require("flash").jump() end,
            desc = "Flash",
          },
          ["F"] = {
            function() require("flash").treesitter() end,
            desc = "Flash Treesitter",
          },
        },
        n = {
          ["f"] = {
            function() require("flash").jump() end,
            desc = "Flash",
          },
          ["F"] = {
            function() require("flash").treesitter() end,
            desc = "Flash Treesitter",
          },
        },
      },
    },
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
