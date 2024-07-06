return {
  "akinsho/toggleterm.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>th"] = false,
          ["<Leader>tv"] = false,
          ["<F7>"] = false,
          ["<Leader>t_"] = { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "ToggleTerm horizontal split" },
          ["<Leader>t|"] = { "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "ToggleTerm vertical split" },
          ["<C-S-.>"] = { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "ToggleTerm horizontal split" },
        },
        t = {
          ["<F7>"] = false,
          ["<M-h>"] = { "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" },
          ["<M-j>"] = { "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" },
          ["<M-k>"] = { "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" },
          ["<M-l>"] = { "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" },
          ["<C-S-.>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
        },
        i = {
          ["<F7>"] = false,
          ["<C-S-.>"] = { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "ToggleTerm horizontal split" },
        },
      },
    },
  },
  opts = {
    -- direction = "horizontal",
  },
}
