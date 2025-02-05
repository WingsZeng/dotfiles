return {
  "loctvl842/monokai-pro.nvim",
  opts = {
    terminal_colors = false,
    override = function(c)
      return {
        CursorColumn = { bg = c.editor.lineHighlightBackground },
      }
    end,
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
}
