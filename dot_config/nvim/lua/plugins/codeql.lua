if true then return {} end
return {
  "pwntester/codeql.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/telescope.nvim",
    "kyazdani42/nvim-web-devicons",
    {
      "AstroNvim/astrolsp",
      opts = function(_, opts)
        opts.servers = opts.servers or {}
        vim.list_extend(opts.servers, {
          "codeqlls",
        })
      end
    }
  },
  opts = {}
}
