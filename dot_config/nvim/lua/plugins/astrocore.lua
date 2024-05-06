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
        -- navigate buffer tabs with `H` and `L`
        K = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        J = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- Standard Operations
        ["<Leader>w"] = false,
        ["<Leader>q"] = false,
        ["<Leader>Q"] = false,
        ["<Leader>n"] = false,
        ["<C-s>"] = false,
        ["\\"] = false,

        ["<C-S-q>"] = { "<cmd>qa<cr>", desc = "Quit all" },
        ["<C-q>"] = { "<cmd>confirm q<cr>", desc = "Quit" },
        ["<C-w>"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" },
        ["_"] = { "<cmd>split<cr>", desc = "Horizontal Split" },
        ["<C-S-j>"] = {"<cmd>move +<cr>", desc = "Move one line down" },
        ["<C-S-k>"] = {"<cmd>move -2<cr>", desc = "Move one line up" },

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
      },
    },
  },
}
