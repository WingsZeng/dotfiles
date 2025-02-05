-- HACK: restore the original keymaps for ";", ";", ";"
-- "f" and "F" is used to Flash, and ";" is used to lsp
-- But in multicursor, they are useless than the original ones
-- I don't know what is the best way.
-- I just use vim cmd to execute the original keymaps
local keymaps = {
  ["f"] = function()
    local char = vim.fn.nr2char(vim.fn.getchar())
    if char == "'" then char = "\\'" end
    vim.cmd("normal! " .. vim.v.count1 .. "f" .. char)
  end,
  ["F"] = function()
    local char = vim.fn.nr2char(vim.fn.getchar())
    if char == "'" then char = "\\'" end
    vim.cmd("normal! " .. vim.v.count1 .. "F" .. char)
  end,
  [";"] = function() vim.cmd("normal! " .. vim.v.count1 .. ";") end,
}

local enter_hook = function()
  local ibl_loaded, _ = pcall(require, "ibl")
  if ibl_loaded then vim.cmd "IBLDisable" end
  local illuminate_loaded, illuminate = pcall(require, "illuminate")
  if illuminate_loaded then illuminate.invisible_buf() end
  for key, _ in pairs(keymaps) do
    vim.api.nvim_buf_set_keymap(0, "n", key, "", { noremap = true, silent = true, callback = keymaps[key] })
  end
end

local exit_hook = function()
  local ibl_loaded, _ = pcall(require, "ibl")
  if ibl_loaded then vim.cmd "IBLEnable" end
  local illuminate_loaded, illuminate = pcall(require, "illuminate")
  if illuminate_loaded then illuminate.visible_buf() end
  for key, _ in pairs(keymaps) do
    pcall(vim.api.nvim_buf_del_keymap, 0, "n", key)
  end
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
      maps.n["<c-s-m>"] = { require("multicursor-nvim").alignCursors, desc = "Align cursors" }

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

      opts.autocmds.exit_multicursor = {
        {
          event = "BufLeave",
          desc = "Exit multicursor when leaving buffer",
          callback = exit_hook,
        },
      }
    end,
  },
  opts = {},
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
