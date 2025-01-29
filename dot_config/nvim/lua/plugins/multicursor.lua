local enter_hook = function()
  local ibl_loaded, _ = pcall(require, "ibl")
  if ibl_loaded then vim.cmd "IBLDisable" end
  local illuminate_loaded, illuminate = pcall(require, "illuminate")
  if illuminate_loaded then illuminate.invisible_buf() end
end

local exit_hook = function()
  local ibl_loaded, _ = pcall(require, "ibl")
  if ibl_loaded then vim.cmd "IBLEnable" end
  local illuminate_loaded, illuminate = pcall(require, "illuminate")
  if illuminate_loaded then illuminate.visible_buf() end
end

return {
  "jake-stewart/multicursor.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = assert(opts.mappings)
      maps.n["<c-m>"] = { require("multicursor-nvim").toggleCursor, desc = "Toggle cursor" }

      maps.n["<c-up>"] = {
        function()
          local mc = require "multicursor-nvim"
          if not mc.hasCursors() then enter_hook() end
          mc.lineAddCursor(-1)
        end,
        desc = "Add cursor above",
      }
      maps.n["<c-down>"] = {
        function()
          local mc = require "multicursor-nvim"
          if not mc.hasCursors() then enter_hook() end
          mc.lineAddCursor(1)
        end,
        desc = "Add cursor below",
      }
      maps.n["<c-n>"] = {
        function()
          local mc = require "multicursor-nvim"
          if not mc.hasCursors() then enter_hook() end
          mc.matchAddCursor(1)
        end,
        desc = "Add cursor to next matched",
      }
      maps.n["<c-s-n>"] = {
        function()
          local mc = require "multicursor-nvim"
          if not mc.hasCursors() then enter_hook() end
          mc.matchAddCursor(-1)
        end,
        desc = "Add cursor to previous matched",
      }

      maps.n["<c-left>"] = { require("multicursor-nvim").prevCursor, desc = "Move main cursor to previous cursor" }
      maps.n["<c-right>"] = { require("multicursor-nvim").nextCursor, desc = "Move main cursor to next cursor" }
      maps.v["<c-left>"] = maps.n["<c-left>"]
      maps.v["<c-right>"] = maps.n["<c-right>"]

      maps.n["<esc>"] = {
        function()
          local mc = require "multicursor-nvim"
          if not mc.cursorsEnabled() then
            if mc.numCursors() > 2 then enter_hook() end
            mc.enableCursors()
          elseif mc.hasCursors() then
            exit_hook()
            mc.clearCursors()
          end
        end,
      }
    end,
  },
  opts = {},
  -- config = function()
  --   local mc = require "multicursor-nvim"
  --   mc.setup()
  --   local hl = vim.api.nvim_set_hl
  --   hl(0, "MultiCursorCursor", { reverse = true })
  -- end,
  specs = {
    {
      "loctvl842/monokai-pro.nvim",
      optional = true,
      opts = {
        override = function(_)
          return {
            MultiCursorCursor = { reverse = true },
          }
        end,
      },
    },
  },
}
