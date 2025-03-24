local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
local function is_visible(cmp) return cmp.core.view:visible() or vim.fn.pumvisible() == 1 end

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "L3MON4D3/LuaSnip" },
  },
  opts = function(_, opts)
    local luasnip, cmp = require "luasnip", require "cmp"
    if not opts.mappings then opts.mappings = {} end

    opts.mapping["<C-P>"] = nil
    opts.mapping["<C-N>"] = nil
    opts.mapping["<C-U>"] = nil
    opts.mapping["<C-D>"] = nil
    opts.mapping["<C-E>"] = nil
    opts.mapping["<C-K>"] = nil
    opts.mapping["<C-J>"] = nil

    opts.mapping["<M-Space>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end)

    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if is_visible(cmp) and has_words_before() then
        cmp.select_next_item()
      elseif vim.api.nvim_get_mode().mode ~= "c" and luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" })
  end,
}
