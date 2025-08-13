local function scroll_lines(lines)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local total_lines = vim.api.nvim_buf_line_count(0)
  local new_line = math.max(1, math.min(total_lines, cursor[1] + lines))

  vim.api.nvim_win_set_cursor(0, { new_line, cursor[2] })
end

return {
  "AstroNvim/astrocore",
  opts = {
    options = {
      opt = {
        signcolumn = "yes",
        foldcolumn = "0",
        cursorcolumn = true,
        jumpoptions = "stack",
        clipboard = "unnamedplus",
      },
    },
    mappings = {
      n = {
        ["<Leader>w"] = false,
        ["<Leader>q"] = false,
        ["<Leader>Q"] = false,
        ["<Leader>n"] = false,
        ["<Leader>R"] = false,
        ["<C-S>"] = false,
        ["<Leader>xq"] = false,
        ["<Leader>xl"] = false,
        ["<Leader>/"] = false,
        ["\\"] = false,

        ["<C-S-Q>"] = { "<cmd>qa<cr>", desc = "Quit all" },
        ["<C-q>"] = { "<cmd>confirm q<cr>", desc = "Quit" },
        ["<C-W>"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" },
        ["_"] = { "<cmd>split<cr>", desc = "Horizontal Split" },

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

        ["<PageUp>"] = {
          function()
            local height = vim.api.nvim_win_get_height(0)
            scroll_lines(-height)
            vim.cmd "normal! zz"
          end,
          desc = "Scroll up",
        },
        ["<PageDown>"] = {
          function()
            local height = vim.api.nvim_win_get_height(0)
            scroll_lines(height)
            vim.cmd "normal! zz"
          end,
          desc = "Scroll down",
        },

        ["<C-/>"] = { "gcc", remap = true, desc = "Toggle comment line" },
      },
      x = {
        ["<C-/>"] = { "gc", remap = true, desc = "Toggle comment" },
      },
    },
  },
}
