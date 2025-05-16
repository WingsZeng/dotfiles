local function enable_flash(notify)
  vim.g.use_flash_f = true
  vim.keymap.set(
    { "n", "x", "o" },
    "f",
    function() require("flash").jump() end,
    { desc = "Flash Jump", noremap = true, silent = true }
  )
  vim.keymap.set(
    { "n", "x", "o" },
    "F",
    function() require("flash").treesitter() end,
    { desc = "Flash Jump", noremap = true, silent = true }
  )
  if notify then vim.notify("Flash jump `f` enabled", nil, { title = "Flash" }) end
end

local function disable_flash(notify)
  vim.g.use_flash_f = false
  vim.keymap.set({ "n", "x", "o" }, "f", "f", { noremap = false, remap = false })
  vim.keymap.set({ "n", "x", "o" }, "F", "F", { noremap = false, remap = false })
  if notify then vim.notify("Flash jump `f` disabled", nil, { title = "Flash" }) end
end

local function toggle_flash()
  if not vim.g.use_flash_f then
    enable_flash(true)
  else
    disable_flash(true)
  end
end

return {
  "folke/flash.nvim",
  specs = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>F"] = {
            toggle_flash,
            desc = "Toggle Flash jump",
          },
        },
      },
    },
  },
  opts = function()
    enable_flash()
    return {
      labels = "asdfjkl",
      search = {
        multi_window = false,
      },
      label = {
        uppercase = false,
        rainbow = {
          enabled = true,
          shade = 5,
        },
      },
      modes = {
        char = {
          enabled = false,
          keys = {},
        },
      },
      highlight = {
        backdrop = false,
      },
      prompt = {
        enabled = false,
      },
    }
  end,
}
