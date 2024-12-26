return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    opts.statusline[1] = status.component.mode { mode_text = { padding = { left = 1, right = 1 } } } -- add the mode text
    table.remove(opts.statusline, #opts.statusline)

    -- HACK: dirty hack to add wordcount provider because I don't know how to do it properly

    ---@diagnostic disable-next-line: inject-field
    status.provider.wordcount = function(_opts)
      return function()
          local wordcount = vim.fn.wordcount()
          local chars = wordcount.visual_chars or wordcount.cursor_chars
        return status.utils.stylize(("%5d"):format(chars), _opts)
      end
    end

    local charcount_componet = function()
      opts = {
        wordcount = {},
        surround = { separator = "right", },
        update = { "CursorMoved", "CursorMovedI", "BufEnter", "TextChanged" },
      }
      return status.component.builder(status.utils.setup_providers(opts, { "wordcount" }))
    end

    -- add word count to last 3rd
    table.insert(opts.statusline, #opts.statusline, charcount_componet())
  end,
}
