return {
  "AstroNvim/astroui",
  opts = {
    lazygit = false,
    highlights = {
      init = {
        CursorColumn = { link = "CursorLine" },
        ["@markup.raw.block.markdown"] = { bg = "NONE" },
        Added = { link = "SignAdd" },
        Changed = { link = "SignChange" },
        Deleted = { link = "SignDelete" },
        DiffText = { underline = true },
      },
    },
  },
}
