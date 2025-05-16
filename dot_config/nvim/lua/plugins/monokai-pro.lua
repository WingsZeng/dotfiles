local dark2 = "#111111"
local dark1 = "#1a1a1a"
local background = "#222222"
local text = "#f8f8f2"
local red = "#f92672"
local orange = "#fd971f"
local yellow = "#e6db74"
local green = "#a6e22e"
local blue = "#66d9ef"
local purple = "#ae81ff"
local dimmed1 = "#a2a2a2"
local dimmed2 = "#888888"
local dimmed3 = "#6f6f6f"
local dimmed4 = "#555555"
local dimmed5 = "#282828"

return {
  "loctvl842/monokai-pro.nvim",
  opts = {
    background_clear = { "float_win" },
    terminal_colors = false,
    overridePalette = function(_)
      return {
        dark2 = dark2,
        dark1 = dark1,
        background = background,
        text = text,
        accent1 = red,
        accent2 = orange,
        accent3 = yellow,
        accent4 = green,
        accent5 = blue,
        accent6 = purple,
        dimmed1 = dimmed1,
        dimmed2 = dimmed2,
        dimmed3 = dimmed3,
        dimmed4 = dimmed4,
        dimmed5 = dimmed5,
      }
    end,
  },
  specs = {
    {
      "AstroNvim/astroui",
      opts = { colorscheme = "monokai-pro" },
    },
    {
      "hedyhli/outline.nvim",
      optional = true,
      specs = {
        "AstroNvim/astroui",
        opts = function(_, opts)
          local outline_hl = { OutlineFoldMarker = { fg = dimmed1 } }
          opts.highlights["monokai-pro"] = vim.tbl_extend("force", opts.highlights["monokai-pro"] or {}, outline_hl)
        end,
      },
    },
    {
      "folke/snacks.nvim",
      optional = true,
      specs = {
        "AstroNvim/astroui",
        opts = function(_, opts)
          if not opts.highlights["monokai-pro"] then opts.highlights["monokai-pro"] = {} end
          local mini_icons_hl = {
            SnacksIndent = { fg = dimmed4 },
            SnacksIndentScope = { fg = dimmed3 },
          }
          opts.highlights["monokai-pro"] = vim.tbl_extend("force", opts.highlights["monokai-pro"] or {}, mini_icons_hl)
        end,
      },
    },
  },
}
