return {
  "nvim-neo-tree/neo-tree.nvim",
  specs = {
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
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
  },
  opts = {
    filesystem = {
      hijack_netrw_behavior = "disabled",
      filtered_items = {
        visible = true,
      },
      use_libuv_file_watcher = true,
    },
    default_component_configs = {
      icon = {
        provider = function(icon, node, _) -- default icon provider utilizes nvim-web-devicons if available
          if node.type == "file" or node.type == "terminal" then
            local success, web_devicons = pcall(require, "nvim-web-devicons")
            local name = node.type == "terminal" and "terminal" or node.name
            if success then
              local devicon, hl = web_devicons.get_icon(name)
              icon.text = devicon or icon.text
              icon.highlight = hl or icon.highlight
            end
          end
        end,
      },
    },
  },
}
