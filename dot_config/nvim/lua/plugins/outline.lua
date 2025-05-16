-- FIX: markdown unfoldall
return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  specs = {
    { "stevearc/aerial.nvim", optional = true, enabled = false },
    { "epheien/outline-treesitter-provider.nvim" },
    {
      "onsails/lspkind.nvim",
      opts = function(_, opts)
        local outline_only_symbols = {
          Namespace = "󰅩",
          Package = "󰏗",
          String = "󱀍",
          Number = "󰎠",
          Boolean = "󰨙",
          Array = "󰅪",
          Object = "󰊱",
          Key = "",
          Null = "",
          Component = "󰅴",
          Fragment = "󰅴",
          TypeAlias = "󰉿",
          Parameter = "",
          StaticMethod = "󰆧",
          Macro = "󰘦",
        }
        opts.symbol_map = vim.tbl_extend("keep", opts.symbol_map or {}, outline_only_symbols)
      end,
    },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>lS"] = false,
            ["<C-s>"] = { function() require("outline").toggle() end, desc = "Symbols outline" },
          },
        },
      },
    },
  },
  opts = {
    outline_window = {
      width = 30,
      relative_width = false,
      focus_on_open = false,
      show_cursorline = true,
      hide_cursor = true,
      auto_jump = true,
      winhl = "Normal:OutlineFoldMarker,OutlineCurrent:QuickFixLine",
    },
    providers = {
      priority = { "lsp", "coc", "markdown", "norg", "treesitter" },
    },
    preview_window = {
      winhl = "NormalFloat:NormalFloat",
    },
    symbols = {
      icon_source = "lspkind",
    },
  },
}
