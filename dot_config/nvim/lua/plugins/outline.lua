-- FIX: markdown unfoldall
return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  dependencies = {
    { "epheien/outline-treesitter-provider.nvim" },
    { "stevearc/aerial.nvim", enabled = false },
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
    keymaps = {
      hover_symbol = ";",
    },
    symbols = {
      icons = {
        File = { icon = "󰪸", hl = "Label" },
        Module = { icon = "󰮄", hl = "Include" },
        Namespace = { icon = "󰅩", hl = "Include" },
        Package = { icon = "󰏗", hl = "Include" },
        Class = { icon = "", hl = "Structure" },
        Method = { icon = "󰆧", hl = "Function" },
        Property = { icon = "", hl = "Label" },
        Field = { icon = "󰆨", hl = "Label" },
        Constructor = { icon = "", hl = "Special" },
        Enum = { icon = "", hl = "Special" },
        Interface = { icon = "", hl = "Special" },
        Function = { icon = "󰊕", hl = "Function" },
        Variable = { icon = "󰀫", hl = "Constant" },
        Constant = { icon = "󰫰", hl = "Constant" },
        String = { icon = "󱌯", hl = "String" },
        Number = { icon = "", hl = "Number" },
        Boolean = { icon = "⊨", hl = "Boolean" },
        Array = { icon = "󰅪", hl = "Constant" },
        Object = { icon = "󰊱", hl = "Special" },
        Key = { icon = "", hl = "Special" },
        Null = { icon = "󱥸", hl = "Special" },
        EnumMember = { icon = "", hl = "Label" },
        Struct = { icon = "󰙅", hl = "Structure" },
        Event = { icon = "", hl = "Special" },
        Operator = { icon = "󰆕", hl = "Label" },
        TypeParameter = { icon = "𝙏", hl = "Label" },
        Component = { icon = "󰅴", hl = "Function" },
        Fragment = { icon = "󰅴", hl = "Constant" },
        TypeAlias = { icon = " ", hl = "Special" },
        Parameter = { icon = " ", hl = "Label" },
        StaticMethod = { icon = "󰆧", hl = "Function" },
        Macro = { icon = "󰘦", hl = "Function" },
      },
    },
  },
}
