return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if not opts.ensure_installed then
      opts.ensure_installed = {}
    end
    vim.list_extend(opts.ensure_installed, {
      "bibtex",
      "cmake",
      "css",
      "cpp",
      "go",
      "html",
      "ini",
      "java",
      "javascript",
      "json",
      "just",
      "kdl",
      "kotlin",
      "llvm",
      "make",
      "meson",
      "ninja",
      "rust",
      "toml",
      "typescript",
      "xml",
      "yaml",
    })
  end,
}
