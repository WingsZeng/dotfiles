local NEOTREE_MIN_COLUMNS = 110
local OUTLINE_MIN_COLUMNS = 126

local neotree_toggled = false

local function toggle_neotree_by_columns()
  if vim.o.columns >= NEOTREE_MIN_COLUMNS then
    require("neo-tree.command").execute { action = "show" }
  else
    require("neo-tree.command").execute { action = "close" }
  end
end

local function toggle_outline_by_columns()
  if
    (vim.o.columns >= OUTLINE_MIN_COLUMNS and not require("outline").is_open())
    or (vim.o.columns < OUTLINE_MIN_COLUMNS and require("outline").is_open())
  then
    require("outline").toggle()
  end
end

return {
  "AstroNvim/astrocore",
  opts = {
    autocmds = {
      toggle_neotree = {
        {
          event = "VimResized",
          callback = toggle_neotree_by_columns,
        },
        {
          event = "User",
          pattern = "VimEnterAfterCheckRestoreSession",
          callback = function()
            toggle_neotree_by_columns()
            neotree_toggled = true
          end,
        },
      },
      toggle_outline = {
        {
          event = "VimResized",
          callback = toggle_outline_by_columns,
        },
        {
          event = "User",
          pattern = "AstroFile",
          callback = toggle_outline_by_columns,
        },
      },
    },
  },
  specs = {
    "stevearc/resession.nvim",
    optional = true,
    specs = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          toggle_sidebar = {
            {
              event = "User",
              pattern = "ResessionLoadPre",
              callback = function()
                -- HACK: Do not know why toggling neo-tree here leads focus on it
                -- if neo-tree is allready open. Let's just check it
                if not neotree_toggled then toggle_neotree_by_columns() end
                toggle_outline_by_columns()
              end,
            },
          },
        },
      },
    },
  },
}
