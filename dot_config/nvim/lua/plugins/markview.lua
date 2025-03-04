return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  ft = function()
    local plugin = require("lazy.core.config").spec.plugins["markview.nvim"]
    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    return opts.preview.filetypes or { "markdown", "quarto", "rmd", "latex" }
  end,
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require("astrocore").list_insert_unique(
            opts.ensure_installed,
            { "html", "markdown", "markdown_inline", "latex" }
          )
        end
      end,
    },
  },
  opts = function(_, opts)
    local presets = require "markview.presets"
    opts.preview = {
      hybrid_modes = { "n" },
      -- HACK: codecompanion must set in here
      filetypes = { "markdown", "quarto", "rmd", "latex", "codecompanion" },
      ignore_buftypes = {},
    }
    opts.markdown = {
      headings = presets.headings.marker,
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
        style = "simple",
        label_direction = "left",
        sign = false,
      },
    }
  end,
}
