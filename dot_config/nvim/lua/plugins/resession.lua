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

        maps.n["<Leader>s"] = vim.tbl_get(opts, "_map_sections", "S")
        maps.n["<Leader>sl"] = { function() require("resession").load "Last Session" end, desc = "Load last session" }
        maps.n["<Leader>ss"] = { function() require("resession").save() end, desc = "Save this session" }
        maps.n["<Leader>sS"] = {
          function() require("resession").save(vim.fn.getcwd(), { dir = "dirsession" }) end,
          desc = "Save this dirsession",
        }
        maps.n["<Leader>st"] = { function() require("resession").save_tab() end, desc = "Save this tab's session" }
        maps.n["<Leader>sd"] = { function() require("resession").delete() end, desc = "Delete a session" }
        maps.n["<Leader>sD"] =
        { function() require("resession").delete(nil, { dir = "dirsession" }) end, desc = "Delete a dirsession" }
        maps.n["<Leader>sf"] = { function() require("resession").load() end, desc = "Load a session" }
        maps.n["<Leader>sF"] =
        { function() require("resession").load(nil, { dir = "dirsession" }) end, desc = "Load a dirsession" }
        maps.n["<Leader>s."] = {
          function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
          desc = "Load current dirsession",
        }

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
                  { dir = "dirsession", silence_errors = true }
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
