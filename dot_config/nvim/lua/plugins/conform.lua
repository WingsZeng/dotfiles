return {
  "stevearc/conform.nvim",
  opts = {
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = function(bufnr)
      if
        vim.F.if_nil(
          vim.b[bufnr].autoformat,
          vim.g.autoformat,
          require("astrolsp").config.formatting.format_on_save.enabled
        )
      then
        return { timeout_ms = 500 }
      end
    end,
  },
}
