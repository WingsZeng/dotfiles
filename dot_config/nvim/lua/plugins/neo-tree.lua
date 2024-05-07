return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>e"] = false,
          ["<Leader>o"] = false,
          ["<C-e>"] = { "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
        },
      },
    },
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
