return {
  "mikavilpas/yazi.nvim",
  lazy = true,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<C-Y>"] = { function() require("yazi").yazi() end, desc = "Open the file manager" },
          },
        },
      },
    },
  },
}
