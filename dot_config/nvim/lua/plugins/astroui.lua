return {
  "AstroNvim/astroui",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        close_if_not_file_buffer = {
          {
            event = "QuitPre",
            callback = function()
              local current_win = vim.api.nvim_get_current_win()
              local wins = vim.api.nvim_list_wins()
              local nonessential_wins = vim.tbl_filter(function(win)
                local buf = vim.api.nvim_win_get_buf(win)
                local ft = vim.bo[buf].filetype
                return vim.tbl_contains({ "neo-tree", "Outline" }, ft)
              end, wins)

              if #wins - #nonessential_wins == 1 and not vim.tbl_contains(nonessential_wins, current_win) then
                for _, win in ipairs(nonessential_wins) do
                  vim.api.nvim_win_close(win, true)
                end
              end
            end,
          },
        },
      },
    },
  },
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
                event = "VimResized",
                callback = function()
                  if vim.o.columns >= 110 then
                    require("neo-tree.command").execute { action = "show" }
                  else
                    require("neo-tree.command").execute { action = "close" }
                  end
                end,
              },
              {
                -- HACK: Do not know how to ensure resession is installed
                -- use a User event to trigger the autocmd in resession
                event = "User",
                pattern = "Restore",
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
                event = "VimResized",
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
                event = "User",
                pattern = { "Restore", "AstroFile" },
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
