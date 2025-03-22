return {
  "loctvl842/monokai-pro.nvim",
  dependencies = {
    "AstroNvim/astroui",
    opts = {
      colorscheme = "monokai-pro",
    },
  },
  opts = {
    terminal_colors = false,
    overridePalette = function(_)
      return {
        dark2 = "#111111",
        dark1 = "#1a1a1a",
        background = "#222222",
        text = "#f8f8f2",
        accent1 = "#f92672",
        accent2 = "#fd971f",
        accent3 = "#e6db74",
        accent4 = "#a6e22e",
        accent5 = "#66d9ef",
        accent6 = "#ae81ff",
        dimmed1 = "#a2a2a2",
        dimmed2 = "#888888",
        dimmed3 = "#6f6f6f",
        dimmed4 = "#555555",
        dimmed5 = "#282828",
      }
    end,
  },
  specs = {
    {
      "hedyhli/outline.nvim",
      optional = true,
      dependencies = {
        "AstroNvim/astroui",
        opts = function(_, opts)
          if not opts.highlights["monokai-pro"] then opts.highlights["monokai-pro"] = {} end
          opts.highlights["monokai-pro"]["OutlineFoldMarker"] =
            { fg = require("monokai-pro.colorscheme").get("classic").base.dimmed1 }
        end,
      },
    },
    {
      "echasnovski/mini.diff",
      optinal = true,
      dependencies = {
        "AstroNvim/astroui",
        opts = function(_, opts)
          if not opts.highlights["monokai-pro"] then opts.highlights["monokai-pro"] = {} end
          opts.highlights["monokai-pro"]["MiniDiffSignAdd"] =
            { fg = require("monokai-pro.colorscheme").get("classic").base.green }
          opts.highlights["monokai-pro"]["MiniDiffSignDelete"] =
            { fg = require("monokai-pro.colorscheme").get("classic").base.red }
          opts.highlights["monokai-pro"]["MiniDiffSignChange"] = { link = "Special" }
        end,
      },
    },
  },
}
