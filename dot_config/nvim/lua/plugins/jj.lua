return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    specs = {
      {
        "Cretezy/neo-tree-jj.nvim",
        dependencies = {
          {
            "nvim-neo-tree/neo-tree.nvim",
            opts = function(_, opts)
              table.insert(opts.sources, "jj")

              -- Replace git tab in neo-tree when in jj repo
              if require("neo-tree.sources.jj.utils").get_repository_root() then
                -- Remove git tab
                for i, source in ipairs(opts.source_selector.sources) do
                  if source.source == "git_status" then
                    table.remove(opts.source_selector.sources, i)
                    break
                  end
                end

                -- Add jj tab
                table.insert(opts.source_selector.sources, {
                  display_name = "󰊢 JJ",
                  source = "jj",
                })
              end
            end,
          },
        },
      },
    },
  },
  { "avm99963/vim-jjdescription", lazy = false },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.autocmds = opts.autocmds or {}

      opts.autocmds.jj_file_user_events = {
        {
          event = { "BufReadPost", "BufNewFile", "BufWritePost" },
          desc = "AstroNvim user event for jj file detection (AstroJJFile)",
          callback = function(args)
            if vim.b[args.buf].astrojjfile_checked then return end
            vim.b[args.buf].astrojjfile_checked = true

            vim.schedule(function()
              if not vim.api.nvim_buf_is_valid(args.buf) then return end

              local current_file = vim.api.nvim_buf_get_name(args.buf)
              if current_file == "" or vim.bo[args.buf].buftype == "nofile" then return end
              if vim.fn.executable "jj" ~= 1 then return end

              local folder = vim.fs.abspath(vim.fs.dirname(current_file))

              local result = vim.system({ "jj", "--ignore-working-copy", "root" }, { cwd = folder, text = true }):wait()

              if result.code == 0 then
                require("astrocore").event "JJFile"
                pcall(vim.api.nvim_del_augroup_by_name, "jj_file_user_events")
              end
            end)
          end,
        },
      }

      return opts
    end,
  },
  {
    "echasnovski/mini.diff",
    optional = true,
    event = "User AstroJJFile",
    dependencies = {
      {
        "ronshavit/mini.diff.jj",
        url = "https://tangled.org/ronshavit.com/mini.diff.jj",
      },
    },
    opts = function(_, opts)
      opts.source = {
        require "mini.diff.jj",
        require("mini.diff").gen_source.git(),
      }

      return opts
    end,
  },
}
