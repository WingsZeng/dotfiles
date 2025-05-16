-- BUG: Leave cmdline reset the cursor column
-- auto open outline when resize window reset the cursor column
-- why this only happens when toggle fullscreen?
return {
  "tummetott/reticle.nvim",
  event = "User AstroFile",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          cursorcolumn_toggle_on_mode_change = {
            {
              event = { "ModeChanged" },
              pattern = { "n:*" },
              callback = function() vim.opt_local.cursorcolumn = false end,
            },
            {
              event = { "ModeChanged" },
              pattern = { "*:n" },
              callback = function() vim.opt_local.cursorcolumn = true end,
            },
          },
        },
      },
    },
  },
  opts = {
    disable_in_insert = false,
    disable_in_diff = false,
    on_startup = {
      cursorline = true,
      cursorcolumn = true,
    },
    ignore = {
      cursorline = {
        "neo-tree",
        "Outline",
        "toggleterm",
        "fzf",
      },
      cursorcolumn = {
        "toggleterm",
        "fzf",
      },
    },
    never = {
      cursorcolumn = {
        "neo-tree",
        "Outline",
        "snacks_dashboard",
      },
    },
  },
}
