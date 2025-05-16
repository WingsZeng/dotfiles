local current_path = nil
return {
  "AstroNvim/astrocore",
  opts = {
    sessions = {
      autosave = {
        cwd = true,
        last = true,
      },
    },
    autocmds = {
      resession_auto_save = {
        {
          event = "VimLeavePre",
          desc = "Save session on close",
          callback = function()
            local buf_utils = require "astrocore.buffer"
            local autosave = require("astrocore").config.sessions.autosave
            if autosave and buf_utils.is_valid_session() then
              local save = require("resession").save
              if autosave.last then save("Last Session", { notify = false }) end
              if autosave.cwd and current_path ~= nil then
                save(current_path, { dir = "dirsession", notify = false })
              end
            end
          end,
        },
      },
      restore_session = {
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
              vim.api.nvim_exec_autocmds("User", { pattern = "VimEnterAfterCheckRestoreSession" })
            end
          end,
        },
      },
    },
  },
}
