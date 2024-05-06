return {
  "mrjones2014/smart-splits.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<C-Up>"] = false
        maps.n["<C-Down>"] = false
        maps.n["<C-Left>"] = false
        maps.n["<C-Right>"] = false
        maps.n["<M-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
        maps.n["<M-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
        maps.n["<M-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
        maps.n["<M-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
        maps.n["<C-k>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
        maps.n["<C-j>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
        maps.n["<C-h>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
        maps.n["<C-l>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
      end,
    },
  },
}
