return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      inlay_hints = true,
    },
    formatting = {
      format_on_save = {
        enabled = false,
      },
    },
    mappings = {
      n = {
        K = false,
        [";"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
      },
    },
  },
}
