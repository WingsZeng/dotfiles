return {
  "stevearc/resession.nvim",
  -- TODO: Refactor opts.
  -- how to get _map_sections without opts?
  -- do I need to set _map_sections S to s?
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
              if autosave and buf_utils.is_valid_session() then
                vim.cmd("Neotree close")
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
                local win = vim.api.nvim_get_current_win()
                vim.cmd("Neotree")
                vim.api.nvim_set_current_win(win)
              end
            end,
          },
        }
      end,
    },
  },
}
