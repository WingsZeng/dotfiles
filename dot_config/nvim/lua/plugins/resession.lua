local current_path = nil
return {
  "stevearc/resession.nvim",
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
        maps.n["<Leader>sl"] = {
          function()
            require("resession").load "Last Session"
            vim.api.nvim_exec_autocmds("User", { pattern = "Restore" })
          end,
          desc = "Load last session",
        }
        maps.n["<Leader>ss"] = { function() require("resession").save() end, desc = "Save this session" }
        maps.n["<Leader>sd"] = { function() require("resession").delete() end, desc = "Delete a session" }
        maps.n["<Leader>sD"] =
          { function() require("resession").delete(nil, { dir = "dirsession" }) end, desc = "Delete a dirsession" }
        maps.n["<Leader>sf"] = {
          function()
            require("resession").load()
            vim.api.nvim_exec_autocmds("User", { pattern = "Restore" })
          end,
          desc = "Load a session",
        }
        maps.n["<Leader>sF"] = {
          function()
            require("resession").load(nil, { dir = "dirsession" })
            vim.api.nvim_exec_autocmds("User", { pattern = "Restore" })
          end,
          desc = "Load a dirsession",
        }

        opts.autocmds.resession_auto_save = {
          {
            event = "VimLeavePre",
            desc = "Save session on close",
            callback = function()
              local buf_utils = require "astrocore.buffer"
              local autosave = buf_utils.sessions.autosave
              if autosave and buf_utils.is_valid_session() then
                local save = require("resession").save
                if autosave.last then save("Last Session", { notify = false }) end
                if autosave.cwd and current_path ~= nil then
                  save(current_path, { dir = "dirsession", notify = false })
                end
              end
            end,
          },
        }
        opts.autocmds.restore_session = {
          {
            event = "VimEnter",
            desc = "Restore dirsession if open a directory",
            nested = true,
            callback = function()
              local argc = vim.fn.argc(-1)
              if argc == 1 then
                local path = vim.fn.argv()[1]
                if vim.fn.isdirectory(path) == 1 then
                  current_path = vim.fn.fnamemodify(path, ":p")
                  if #current_path > 1 and current_path:sub(-1) == "/" then current_path = current_path:sub(1, -2) end
                  require("resession").load(current_path, { dir = "dirsession", silence_errors = true })
                end
              end
              if argc ~= 0 then
                if current_path == nil then current_path = vim.fn.getcwd() end
                -- HACK:
                vim.api.nvim_exec_autocmds("User", { pattern = "Restore" })
              end
            end,
          },
        }
      end,
    },
  },
  opts = {},
}
