return {
  "numToStr/Comment.nvim",
  dependencies =  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>/"] = false,
          ["<C-/>"] = {
            function()
              return require("Comment.api").call(
                "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
                "g@$"
              )()
            end,
            expr = true,
            silent = true,
            desc = "Toggle comment line",
          },
        },
        x = {
          ["<Leader>/"] = false,
        },
        v = {
          ["<C-/>"] = {
            "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
            desc = "Toggle comment for selection",
          },
        },
      },
    },
  },
  opts = {
    mappings = {
      basic = false,
      extra = false,
    },
  },
}
