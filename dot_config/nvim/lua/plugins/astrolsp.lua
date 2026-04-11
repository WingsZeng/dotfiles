return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      inlay_hints = true,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = false,
      },
    },
    config = {
      tinymist = {
        settings = {
          exportPdf = "onType",
          formatterMode = "typstyle",
          lint = {
            enable = true,
            when = "onType",
          },
          projectResolution = "lockDatabase",
        },
      },
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportWildcardImportFromLibrary = "none",
              },
            },
          },
        },
      },
      ruff = {
        init_options = {
          settings = {
            lint = {
              enable = false,
            },
          },
        },
      },
    },
  },
}
