return {
  "Zeioth/compiler.nvim",
  cmd = { "CompilerOpen", "CompilerToggleResults" },
  dependencies = {
    {
      "stevearc/overseer.nvim",
      opts = {
        task_list = {
          direction = "bottom",
          min_height = 5,
          max_height = 10,
          default_detail = 1,
          bindings = {
            ["q"] = function() vim.cmd "OverseerClose" end,
          },
        },
      },
    },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<C-b>"] = { "<cmd>CompilerOpen<cr>", desc = "Open compiler" },
            ["<C-S-b>"] = { "<cmd>CompilerToggleResults<cr>", desc = "Toggle compiler results" },
          },
        },
      },
    },
  },
  opts = {},
}
