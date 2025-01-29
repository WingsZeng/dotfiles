local keys = {
  ["f"] = {
    function()
      -- HACK: shoud i use specs?
      local multicursor_enabled, mc = pcall(require, "multicursor-nvim")
      if multicursor_enabled and mc.numCursors() > 1 then
        local char = vim.fn.nr2char(vim.fn.getchar())
        vim.cmd("execute 'normal! " .. vim.v.count1 .. "f" .. char .. "'")
      else
        require("flash").jump()
      end
    end,
    desc = "Flash",
  },
  ["F"] = {
    function()
      -- HACK: shoud i use specs?
      local multicursor_enabled, mc = pcall(require, "multicursor-nvim")
      if multicursor_enabled and mc.numCursors() > 1 then
        local char = vim.fn.nr2char(vim.fn.getchar())
        vim.cmd("execute 'normal! " .. vim.v.count1 .. "F" .. char .. "'")
      else
        require("flash").treesitter()
      end
    end,
    desc = "Flash Treesitter",
  },
}

return {
  "folke/flash.nvim",
  layz = true,
  event = "User AstroFile",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        x = keys,
        o = keys,
        n = keys,
      },
    },
  },
  opts = {
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
  },
}
