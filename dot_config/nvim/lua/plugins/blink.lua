local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
  "Saghen/blink.cmp",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          i = {
            ["<M-Space>"] = { function() end },
          },
        },
      },
    },
    { "onsails/lspkind.nvim", lazy = true },
  },
  opts = {
    completion = {
      list = {
        selection = {
          auto_insert = false,
        },
      },
      menu = {
        draw = {
          gap = 2,
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                ctx.kind_icon = icon or ""
                return ctx.kind_icon or ctx.kind
              end,
            },
          },
        },
      },
    },
    keymap = {
      ["<C-Space>"] = {},
      ["<C-N>"] = {},
      ["<C-P>"] = {},
      ["<C-U>"] = {},
      ["<C-D>"] = {},
      ["<C-e>"] = {},

      ["<C-K>"] = { "scroll_documentation_up", "fallback" },
      ["<C-J>"] = { "scroll_documentation_down", "fallback" },

      ["<M-Space>"] = {
        function(cmp)
          if cmp.is_visible() then
            cmp.cancel()
          else
            cmp.show()
          end
        end,
        "fallback",
      },

      ["<Tab>"] = {
        "select_next",
        "snippet_forward",
        function(cmp)
          if cmp.is_visible() and (has_words_before() or vim.api.nvim_get_mode().mode == "c") then return cmp.show() end
        end,
        "fallback",
      },
    },
  },
}
