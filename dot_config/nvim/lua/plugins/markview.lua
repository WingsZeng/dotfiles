return {
  "OXY2DEV/markview.nvim",
  ft = function()
    local plugin = require("lazy.core.config").spec.plugins["markview.nvim"]
    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    return opts.preview.filetypes or { "markdown", "quarto", "rmd" }
  end,
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed =
            require("astrocore").list_insert_unique(opts.ensure_installed, { "html", "markdown", "markdown_inline" })
        end
      end,
    },
  },
  opts = function(_, opts)
    local presets = require "markview.presets"
    local my_headings = presets.headings.glow
    my_headings.heading_1 = presets.headings.simple.heading_6
    my_headings.heading_1.sign = ""
    my_headings.heading_2.sign = ""
    my_headings.heading_2.icon = "█ "
    my_headings.heading_3.icon = "█ "
    my_headings.heading_4.icon = "█ "
    my_headings.heading_5.icon = "█ "
    my_headings.heading_6.icon = "█ "
    my_headings.heading_2.padding_left = ""
    my_headings.heading_3.padding_left = ""
    my_headings.heading_4.padding_left = ""
    my_headings.heading_5.padding_left = ""
    my_headings.heading_6.padding_left = ""

    if opts.preview == nil then opts.preview = {} end
    opts.preview.hybrid_modes = { "n" }
    opts.preview.ignore_buftypes = {}

    if opts.preview.filetypes == nil then
      opts.preview.filetypes = { "markdown", "quarto", "rmd" }
    else
      opts.preview.filetypes =
        require("astrocore").list_insert_unique(opts.preview.filetypes, { "markdown", "quarto", "rmd" })
    end

    opts.markdown = {
      headings = my_headings,
      tables = presets.tables.none,
      list_items = {
        shift_width = 0,
        marker_minus = {
          add_padding = false,
          text = "•",
        },
        marker_plus = {
          add_padding = false,
          text = "▸",
        },
        marker_star = {
          add_padding = false,
          text = "◊",
        },
      },
      code_blocks = {
        enable = false,
      },
      horizontal_rules = presets.horizontal_rules.dashed,
    }
  end,
}
