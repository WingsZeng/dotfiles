return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>e"] = false
        maps.n["<Leader>o"] = false
        maps.n["<C-e>"] = { "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" }
      end,
    }
  },
  opts = {
    filesystem = {
      hijack_netrw_behavior = "disabled",
      filtered_items = {
        visible = true,
      },
    },
  },
}
