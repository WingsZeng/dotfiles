return {
  "numToStr/Comment.nvim",
  dependencies =  {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>/"] = false
        maps.x["<Leader>/"] = false
        maps.n["<C-/>"] = {
          function()
            return require("Comment.api").call(
              "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
              "g@$"
            )()
          end,
          expr = true,
          silent = true,
          desc = "Toggle comment line",
        }
        maps.v["<C-/>"] = {
          "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
          desc = "Toggle comment for selection",
        }
      end,
    },
  },
  opts = {
    mappings = {
      basic = false,
      extra = false,
    },
  }
}
