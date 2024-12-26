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
        [';'] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
        gd = { function() require("telescope.builtin").lsp_definitions { reuse_win = true } end, desc = "Go to definition" },
        gI = { function() require("telescope.builtin").lsp_implementations { reuse_win = true } end, desc = "Go to implementation" },
        gy = { function() require("telescope.builtin").lsp_type_definitions { reuse_win = true } end, desc = "Go to type definition" },
        ["<Leader>lG"] = { function()
          vim.ui.input({ prompt = "Symbol Query: (leave empty for word under cursor)" }, function(query)
            if query then
              -- word under cursor if given query is empty
              if query == "" then query = vim.fn.expand "<cword>" end
              require("telescope.builtin").lsp_workspace_symbols {
                query = query,
                prompt_title = ("Find word (%s)"):format(query),
              }
            end
          end)
        end, desc = "Find workspace symbol" },
        ["<Leader>lR"] = { function() require("telescope.builtin").lsp_references() end, desc = "Find references" },
      },
    },
  },
}
