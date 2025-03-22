return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>e"] = false,
          ["<Leader>o"] = false,
          ["<C-E>"] = {
            function() require("neo-tree.command").execute { action = "show", toggle = true } end,
            desc = "Toggle Explorer",
          },
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
      use_libuv_file_watcher = true,
    },
  },
}
