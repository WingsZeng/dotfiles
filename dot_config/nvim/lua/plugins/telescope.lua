return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local astro = require "astrocore"
          local is_available = astro.is_available
          maps.n["<Leader>f/"] = false
          if vim.fn.executable "rg" == 1 then
            maps.n["<Leader>fw"] = false
            maps.n["<Leader>fW"] = false
            maps.n["<C-f>"] = {
              function()
                require("telescope.builtin").live_grep {
                  additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
                }
              end,
              desc = "Find words in all files",
            }
          end
          maps.n["<Leader>ls"] = false
          maps.n["<Leader>fs"] = {
            function()
              if is_available "aerial.nvim" then
                require("telescope").extensions.aerial.aerial()
              else
                require("telescope.builtin").lsp_document_symbols()
              end
            end,
            desc = "Find symbols",
          }
        end,
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      if require("astrocore").is_available "telescope.nvim" then
        local maps = opts.mappings
        maps.n["<Leader>lD"] = false
        maps.n["<Leader>fd"] =
          { function() require("telescope.builtin").diagnostics() end, desc = "Find diagnostics" }
      end
    end,
  },
}
