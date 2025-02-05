local keys = {
  ["f"] = { require("flash").jump, desc = "Flash" },
  ["F"] = { require("flash").treesitter, desc = "Flash Treesitter" },
}

return {
  "folke/flash.nvim",
  layz = true,
  event = "User AstroFile",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        x = keys,
        o = keys,
        n = keys,
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
