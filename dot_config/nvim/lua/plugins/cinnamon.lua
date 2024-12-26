-- TODO: integrate with telescope

local function scroll_cursor(lines)
  local current_win = vim.api.nvim_get_current_win()
  local max_rows = vim.api.nvim_buf_line_count(vim.api.nvim_win_get_buf(current_win))
  local cursor_pos = vim.api.nvim_win_get_cursor(current_win)
  local new_cursor_row = cursor_pos[1] + lines

  if new_cursor_row < 1 then
    new_cursor_row = 1
  elseif new_cursor_row > max_rows then
    new_cursor_row = max_rows
  end

  vim.api.nvim_win_set_cursor(current_win, { new_cursor_row, cursor_pos[2] })
end

return {
  "declancm/cinnamon.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local cinnamon = require "cinnamon"

        local keymap = {
          ["<PageUp>"]   = function()
            cinnamon.scroll(function()
              scroll_cursor(-vim.api.nvim_win_get_height(0))
              vim.cmd "normal! zz"
            end)
          end,
          ["<PageDown>"] = function()
            cinnamon.scroll(function()
              scroll_cursor(vim.api.nvim_win_get_height(0))
              vim.cmd "normal! zz"
            end)
          end,
        }
        local modes = { 'n', 'v', 'i' }
        for _, mode in ipairs(modes) do
          opts.mappings[mode] = opts.mappings[mode] or {}
          for k, v in pairs(keymap) do
            opts.mappings[mode][k] = v
          end
        end

        opts.mappings['n']["<Home>"] = function() cinnamon.scroll("<Home>") end
        opts.mappings['n']["<End>"] = function() cinnamon.scroll("<End>") end
        opts.mappings['v']["<Home>"] = function() cinnamon.scroll("<Home>") end
        opts.mappings['v']["<End>"] = function() cinnamon.scroll("<End>") end
        opts.mappings['n']["*"] = function() cinnamon.scroll("*zz") end
        opts.mappings['n']["#"] = function() cinnamon.scroll("#zz") end
        opts.mappings['n']["n"] = function() cinnamon.scroll("nzz") end
        opts.mappings['n']["N"] = function() cinnamon.scroll("Nzz") end

        opts.mappings['v']["o"] = function() cinnamon.scroll("o") end
      end
    },
  },

  opts = function(_, opts)
    opts.keymaps = {
      basic = true,
      extra = true,
    }

    -- HACK: dirty hack to center the cursor after jumping
    local cinnamon = require "cinnamon"
    local show_document = vim.lsp.util.show_document
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.util.show_document = function(location, offset_encoding, _opts)
      cinnamon.scroll(function()
        show_document(location, offset_encoding, _opts)
        vim.cmd "normal! zz"
      end)
    end
  end,

  specs = {
    "folke/flash.nvim",
    optional = true,
    opts = function(_, opts)
      local cinnamon = require("cinnamon")
      local jump = require("flash.jump")
      opts.action = function(match, state)
        cinnamon.scroll(function()
          jump.jump(match, state)
          jump.on_jump(state)
        end)
      end
    end,
  }
}
