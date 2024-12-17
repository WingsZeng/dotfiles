return {
  "AstroNvim/astrocore",
  opts = {
    options = {
      opt = {
        signcolumn = "yes",
      },
    },
    mappings = {
      n = {
        -- Standard Operations
        ["<Leader>w"] = false,
        ["<Leader>q"] = false,
        ["<Leader>Q"] = false,
        ["<Leader>n"] = false,
        ["<C-S>"] = false,
        ["\\"] = false,

        ["<C-S-Q>"] = { "<cmd>qa<cr>", desc = "Quit all" },
        ["<C-q>"] = { "<cmd>confirm q<cr>", desc = "Quit" },
        ["<C-W>"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" },
        ["_"] = { "<cmd>split<cr>", desc = "Horizontal Split" },
        K = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        J = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- Manage Buffers
        ["<Leader>c"] = false,
        ["<Leader>C"] = false,
        ["<Leader>b\\"] = false,
        ["<Leader>b_"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              vim.cmd.split()
              vim.api.nvim_win_set_buf(0, bufnr)
            end)
          end,
          desc = "Horizontal split buffer from tabline",
        },


        ["<Leader>xq"] = false,
        ["<Leader>xl"] = false,

      },
    },
  },
}
