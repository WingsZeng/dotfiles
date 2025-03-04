return {
  "AstroNvim/astrocore",
  opts = {
    options = {
      opt = {
        signcolumn = "yes",
        cursorcolumn = true,
        jumpoptions = "stack",
      },
    },
    mappings = {
      n = {
        -- Standard Operations
        ["<Leader>w"] = false,
        ["<Leader>q"] = false,
        ["<Leader>Q"] = false,
        ["<Leader>n"] = false,
        ["<Leader>R"] = false,
        ["<C-S>"] = false,
        ["\\"] = false,

        ["<C-S-Q>"] = { "<cmd>qa<cr>", desc = "Quit all" },
        ["<C-q>"] = { "<cmd>confirm q<cr>", desc = "Quit" },
        ["<C-W>"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" },
        ["_"] = { "<cmd>split<cr>", desc = "Horizontal Split" },
        K = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        J = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<C-a>"] = { function() vim.cmd "norm! ggVG" end, desc = "Select all" },

        -- Manage Buffers
        ["<Leader>c"] = false,
        ["<Leader>C"] = false,
        ["<Leader>b\\"] = false,
        ["<Leader>b_"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              vim.cmd.split()
              vim.api.nvim_win_set_buf(0, bufnr)
            end)
          end,
          desc = "Horizontal split buffer from tabline",
        },

        ["<Leader>br"] = { function() require("astrocore").rename_file() end, desc = "Rename file" },

        ["<Leader>xq"] = false,
        ["<Leader>xl"] = false,
      },
    },
    autocmds = {
      cursorcolumn = {
        {
          event = { "WinEnter", "FileType" },
          callback = function()
            local ft = vim.bo.filetype
            if ft == "neo-tree" or ft == "aerial" then vim.opt_local.cursorcolumn = false end
          end,
        },
        {
          event = { "ModeChanged" },
          pattern = { "n:*" },
          callback = function() vim.opt_local.cursorcolumn = false end,
        },
        {
          event = { "ModeChanged" },
          pattern = { "*:n" },
          callback = function() vim.opt_local.cursorcolumn = true end,
        },
      },
    },
  },
}
