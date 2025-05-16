-- TODO: Use event to toggle flash jump `f`? No event in this plugins
return {
  "jake-stewart/multicursor.nvim",
  specs = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<BS>"] = { require("multicursor-nvim").toggleCursor, desc = "Toggle cursor" }

      maps.n["<C-up>"] = {
        function() require("multicursor-nvim").lineAddCursor(-1) end,
        desc = "Add cursor above",
      }
      maps.n["<C-down>"] = {
        function() require("multicursor-nvim").lineAddCursor(1) end,
        desc = "Add cursor below",
      }
      maps.n["<C-n>"] = {
        function() require("multicursor-nvim").matchAddCursor(1) end,
        desc = "Add cursor to next matched",
      }
      maps.n["<C-S-n>"] = {
        function() require("multicursor-nvim").matchAddCursor(-1) end,
        desc = "Add cursor to previous matched",
      }
      maps.n["<C-S-a>"] = { require("multicursor-nvim").alignCursors, desc = "Align cursors" }

      maps.n["<C-left>"] = { require("multicursor-nvim").prevCursor, desc = "Move main cursor to previous cursor" }
      maps.n["<C-right>"] = { require("multicursor-nvim").nextCursor, desc = "Move main cursor to next cursor" }
      maps.v["<C-left>"] = maps.n["<C-left>"]
      maps.v["<C-right>"] = maps.n["<C-right>"]

      maps.n["<ESC>"] = {
        function()
          local mc = require "multicursor-nvim"
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          elseif mc.hasCursors() then
            mc.clearCursors()
          end
        end,
      }
    end,
  },
  opts = {},
}
