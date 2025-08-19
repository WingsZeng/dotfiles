return {
  "altermo/ultimate-autopair.nvim",
  opts = {
    config_internal_pairs = {
      { "[", "]", suround = true },
      { "(", ")", suround = true },
      { "{", "}", suround = true },
      { '"', '"', dosuround = true },
      { "'", "'", dosuround = true },
      { "`", "`", dosuround = true },
      { "``", "''", dosuround = true },
      { "```", "```", ft = { "markdown", "typst" } },
    },
  },
  config = function(_, opts)
    local ua = require "ultimate-autopair"
    local config = ua.extend_default(opts)

    vim.list_extend(config, {
      { "$", "$", ft = { "tex", "markdown", "typst" }, fly = true, dosuround = true, space = true },
      {
        "$$",
        "$$",
        ft = { "tex", "markdown" },
        fly = true,
        dosuround = true,
        space = true,
        newline = true,
        multiline = true,
        alpha_after = true,
      },
      { "*", "*", ft = { "typst" }, dosuround = true },
      { "**", "**", ft = { "markdown" }, dosuround = true },
      { "_", "_", ft = { "typst" }, dosuround = true },
      { "__", "__", ft = { "markdown" }, dosuround = true },
    })

    ua.init { config }
  end,
}
