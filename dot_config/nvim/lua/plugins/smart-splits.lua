return {
  "mrjones2014/smart-splits.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<C-Up>"] = false,
          ["<C-Down>"] = false,
          ["<C-Left>"] = false,
          ["<C-Right>"] = false,
          ["<M-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
          ["<M-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
          ["<M-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
          ["<M-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
          ["<C-k>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
          ["<C-j>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
          ["<C-h>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
          ["<C-l>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
        },
      },
    },
  },
}
