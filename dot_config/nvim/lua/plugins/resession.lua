return {
  "stevearc/resession.nvim",
  -- FIX: resession directory or fallback.
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>S"] = false
        maps.n["<Leader>Sl"] = false
        maps.n["<Leader>Ss"] = false
        maps.n["<Leader>SS"] = false
        maps.n["<Leader>St"] = false
        maps.n["<Leader>Sd"] = false
        maps.n["<Leader>SD"] = false
        maps.n["<Leader>Sf"] = false
        maps.n["<Leader>SF"] = false
        maps.n["<Leader>S."] = false

        opts.autocmds.resession_auto_save = {
          {
            event = "VimLeavePre",
            desc = "Save session on close",
            callback = function()
              local buf_utils = require "astrocore.buffer"
              local autosave = buf_utils.sessions.autosave
              local aerial_loaded, aerial = pcall(require, "aerial")
              if aerial_loaded and aerial.is_open() then
                aerial.close()
              end
              if autosave and buf_utils.is_valid_session() then
                local save = require("resession").save
                if autosave.last then save("Last Session", { notify = false }) end
                if autosave.cwd then save(vim.fn.getcwd(), { dir = "dirsession", notify = false }) end
              end
            end,
          },
        }
        opts.autocmds.restore_session = {
          {
            event = "VimEnter",
            desc = "Restore previous directory session if neovim opened in cwd",
            nested = true,
            callback = function()
              local argc = vim.fn.argc(-1)
              if argc == 1 and vim.fn.argv()[1] == "." then
                require("resession").load(
                  vim.fn.getcwd(),
                  { dir = "dirsession", silence_errors = false }
                )
              end
              local aerial = require("aerial")
              if not aerial.is_open() then
                aerial.open({ focus = false })
              end
              require("neo-tree.command").execute({ action = "show" })
            end,
          },
        }
      end,
    },
  },
  opts = {
    extensions = {
      aerial = {
        enable_in_tab = true,
      }
    }
  }
}
