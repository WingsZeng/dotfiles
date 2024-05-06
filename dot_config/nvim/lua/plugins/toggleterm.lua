return {
  "akinsho/toggleterm.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>th"] = false
        maps.n["<Leader>tv"] = false
        maps.n["<F7>"] = false
        maps.t["<F7>"] = false
        maps.i["<F7>"] = false
        maps.n["<Leader>t_"] = { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "ToggleTerm horizontal split" }
        maps.n["<Leader>t|"] = { "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "ToggleTerm vertical split" }

        maps.t["<M-h>"] = { "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" }
        maps.t["<M-j>"] = { "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" }
        maps.t["<M-k>"] = { "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" }
        maps.t["<M-l>"] = { "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" }
      end,
    },
  },
  opts = {
    direction = "horizontal",
  },
}
