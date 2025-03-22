return {
  'willothy/moveline.nvim',
  build = 'make',
  event = "User AstroFile",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<C-S-J>"] = { function() require("moveline").down() end, desc = "Move one line down" },
          ["<C-S-K>"] = { function() require("moveline").up() end, desc = "Move one line up" },
        },
        i = {
          ["<C-S-J>"] = { function() require("moveline").down() end, desc = "Move one line down" },
          ["<C-S-K>"] = { function() require("moveline").up() end, desc = "Move one line up" },
        },
        v = {
          ["<C-S-J>"] = { function() require("moveline").block_down() end, desc = "Move lines down" },
          ["<C-S-K>"] = { function() require("moveline").block_up() end, desc = "Move lines up" },
        },
      },
    },
  },
}
