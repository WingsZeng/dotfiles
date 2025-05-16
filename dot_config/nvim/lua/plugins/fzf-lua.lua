return {
  "ibhagwan/fzf-lua",
  specs = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<C-F>"] = { function() require("fzf-lua").lgrep_curbuf() end, desc = "Find words in current buffer" }
      if vim.fn.executable "rg" == 1 or vim.fn.executable "grep" == 1 then
        maps.n["<C-S-F>"] = { function() require("fzf-lua").live_grep_native() end, desc = "Find words" }
      end
    end,
  },
}
