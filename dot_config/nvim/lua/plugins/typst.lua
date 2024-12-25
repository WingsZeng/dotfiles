return {
  { "kaarmu/typst.vim", ft = { "typst" } },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "tinymist" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "tinymist" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        tinymist = {
          settings = {
            exportPdf = "onType",
          },
        },
      }
    },
  },
}
