return {
  "AstroNvim/astroui",
  opts = {
    lazygit = false,
    highlights = {
      init = {
        CursorColumn = { link = "CursorLine" },
        ["@markup.raw.block.markdown"] = { bg = "NONE" },
      },
    },
  },
  specs = {
    {
      "nvim-neo-tree/neo-tree.nvim",
      optional = true,
      dependencies = {
        "AstroNvim/astrocore",
        opts = {
          autocmds = {
            toggle_neotree = {
              {
                event = { "VimResized" },
                callback = function()
                  if vim.o.columns >= 110 then
                    require("neo-tree.command").execute { action = "show" }
                  else
                    require("neo-tree.command").execute { action = "close" }
                  end
                end,
              },
              {
                event = { "User" },
                pattern = { "AstroFile" },
                callback = function()
                  if vim.o.columns >= 110 then require("neo-tree.command").execute { action = "show" } end
                end,
              },
            },
          },
        },
      },
    },
    {
      "hedyhli/outline.nvim",
      optional = true,
      dependencies = {
        "AstroNvim/astrocore",
        opts = {
          autocmds = {
            toggle_outline = {
              {
                event = { "VimResized" },
                callback = function()
                  if
                    (vim.o.columns >= 126 and not require("outline").is_open())
                    or (vim.o.columns < 126 and require("outline").is_open())
                  then
                    require("outline").toggle()
                  end
                end,
              },
              {
                event = { "User" },
                pattern = { "AstroFile" },
                callback = function()
                  if vim.o.columns >= 126 then require("outline").open() end
                end,
              },
            },
          },
        },
      },
    },
  },
}
