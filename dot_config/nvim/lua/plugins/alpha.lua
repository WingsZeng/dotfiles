return {
  "goolord/alpha-nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>h"] = false
      end,
    },
  },
  opts = function(_, opts)
    opts.section.header.val = {
      " █████   ███   █████  ███                             ",
      "░░███   ░███  ░░███  ░░░                              ",
      " ░███   ░███   ░███  ████  ████████    ███████  █████ ",
      " ░███   ░███   ░███ ░░███ ░░███░░███  ███░░███ ███░░  ",
      " ░░███  █████  ███   ░███  ░███ ░███ ░███ ░███░░█████ ",
      "  ░░░█████░█████░    ░███  ░███ ░███ ░███ ░███ ░░░░███",
      "    ░░███ ░░███      █████ ████ █████░░███████ ██████ ",
      "     ░░░   ░░░      ░░░░░ ░░░░ ░░░░░  ░░░░░███░░░░░░  ",
      "                                      ███ ░███        ",
      "                                     ░░██████         ",
      "                                      ░░░░░░          ",
    }
    opts.section.buttons.val = {}
    return opts
  end,
}
