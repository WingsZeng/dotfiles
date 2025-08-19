return {
  "echasnovski/mini.animate",
  opts = function()
    -- don't use animate when scrolling with the mouse
    local mouse_scrolled = false
    for _, scroll in ipairs { "Up", "Down" } do
      local key = "<ScrollWheel" .. scroll .. ">"
      vim.keymap.set({ "", "i" }, key, function()
        mouse_scrolled = true
        return key
      end, { expr = true })
    end

    -- don't use animate when scrolling with single keys
    local single_key_scrolled = false
    for _, key in ipairs { "j", "k", "<Up>", "<Down>" } do
      vim.keymap.set("n", key, function()
        single_key_scrolled = true
        return key
      end, { expr = true, noremap = true })
    end

    local animate = require "mini.animate"

    return {
      scroll = {
        subscroll = animate.gen_subscroll.equal {
          predicate = function(total_scroll)
            if mouse_scrolled then
              mouse_scrolled = false
              return false
            end
            if single_key_scrolled then
              single_key_scrolled = false
              return false
            end
            return total_scroll > 1
          end,
        },
      },
      cursor = { enable = false },
      resize = { enable = false },
      open = { enable = false },
      close = { enable = false },
    }
  end,
}
