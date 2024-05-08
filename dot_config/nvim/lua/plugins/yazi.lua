return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<C-y>", function() require("yazi").yazi() end, desc = "Open the file manager" },
  },
}
