---@diagnostic disable: undefined-field
local M = {}

local ns_id = vim.api.nvim_create_namespace "spinner"

M.config = {
  spinner = {
    text = "",
    hl_positions = {
      { 0, 3 }, -- First circle
      { 3, 6 }, -- Second circle
      { 6, 9 }, -- Third circle
    },
    interval = 100,
    hl_group = "CursorLineNr",
    hl_dim_group = "LineNr",
  },
}

local spinner_state = {
  timer = nil,
  win = nil,
  buf = nil,
  frame = 1,
}

local function create_spinner_window()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

  local win = vim.api.nvim_open_win(buf, false, {
    relative = "cursor",
    row = -1,
    col = 0,
    width = 3,
    height = 1,
    style = "minimal",
    focusable = false,
  })

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { M.config.spinner.text })

  -- Set the dim highlight for the entire text
  vim.api.nvim_buf_set_extmark(buf, ns_id, 0, 0, {
    end_col = 9,
    hl_group = M.config.spinner.hl_dim_group,
    priority = vim.highlight.priorities.user - 1,
  })

  return buf, win, ns_id
end

function M.start_spinner()
  if spinner_state.timer then return end

  local buf, win = create_spinner_window()
  spinner_state.buf = buf
  spinner_state.win = win

  spinner_state.timer = vim.loop.new_timer()
  spinner_state.timer:start(
    0,
    M.config.spinner.interval,
    vim.schedule_wrap(function()
      if
        spinner_state.win == nil
        or spinner_state.buf == nil
        or not (vim.api.nvim_win_is_valid(spinner_state.win) and vim.api.nvim_buf_is_valid(spinner_state.buf))
      then
        M.stop_spinner()
        return
      end

      -- Update window position relative to cursor
      local ok = pcall(vim.api.nvim_win_set_config, spinner_state.win, {
        relative = "cursor",
        row = -1,
        col = 0,
      })

      -- If window update failed, stop the spinner
      if not ok then
        M.stop_spinner()
        return
      end
      vim.api.nvim_buf_clear_namespace(spinner_state.buf, ns_id, 0, -1)

      vim.api.nvim_buf_set_extmark(spinner_state.buf, ns_id, 0, 0, {
        end_col = 9,
        hl_group = M.config.spinner.hl_dim_group,
        priority = vim.highlight.priorities.user - 1,
      })

      -- Set animation highlight
      local hl_pos = M.config.spinner.hl_positions[spinner_state.frame]
      vim.api.nvim_buf_set_extmark(spinner_state.buf, ns_id, 0, hl_pos[1], {
        end_col = hl_pos[2],
        hl_group = M.config.spinner.hl_group,
        priority = vim.highlight.priorities.user + 1,
      })

      spinner_state.frame = (spinner_state.frame % #M.config.spinner.hl_positions) + 1
    end)
  )
end

function M.stop_spinner()
  if spinner_state.timer then
    spinner_state.timer:stop()
    spinner_state.timer:close()
    spinner_state.timer = nil
  end

  -- safely close the window if it exists and is valid
  if spinner_state.win then
    pcall(vim.api.nvim_win_close, spinner_state.win, true)
    spinner_state.win = nil
  end

  if spinner_state.buf then
    pcall(vim.api.nvim_buf_delete, spinner_state.buf, { force = true })
    spinner_state.buf = nil
  end
  spinner_state.frame = 1
end

return {
  "olimorris/codecompanion.nvim",
  specs = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
    { "echasnovski/mini.diff" },
    { "ibhagwan/fzf-lua" },
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        local prefix = opts.options.g.copilot_chat_prefix or "<Leader>c"
        local astroui = require "astroui"
        local codecompanion = require "codecompanion"

        maps.n[prefix] = { desc = astroui.get_icon("CodeCompanion", 1, true) .. "CodeCompanion" }
        maps.v[prefix] = maps.n[prefix]

        maps.n[prefix .. "a"] = { "<Cmd>CodeCompanionActions<CR>", desc = "Action Palette" }
        maps.v[prefix .. "a"] = maps.n[prefix .. "a"]
        maps.n[prefix .. "c"] = { "<Cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle Chat" }
        maps.v[prefix .. "c"] = maps.n[prefix .. "c"]
        maps.n[prefix .. "C"] = { "<Cmd>CodeCompanionChat<CR>", desc = "New Chat" }
        maps.v[prefix .. "C"] = maps.n[prefix .. "C"]
        maps.n[prefix .. "i"] = {
          function()
            vim.ui.input({ prompt = "Prompt: " }, function(input)
              if input and input ~= "" then vim.cmd("CodeCompanion #buffer " .. input) end
            end)
          end,
          desc = "Prompt Inline",
        }
        maps.v[prefix .. "i"] = { ":CodeCompanion<CR>", desc = "Prompt Inline" }
        maps.v[prefix .. "e"] = { function() codecompanion.prompt "explain" end, desc = "Explain Code" }
        maps.v[prefix .. "f"] = { function() codecompanion.prompt "fix" end, desc = "Fix Code" }
        maps.n[prefix .. "l"] = { function() codecompanion.prompt "lsp" end, desc = "Explain LSP Diagnostics" }
        maps.n[prefix .. "m"] = { function() codecompanion.prompt "commit" end, desc = "Generate Commit Message" }
        maps.v[prefix .. "t"] = { function() codecompanion.prompt "tests" end, desc = "Generate Unit Tests" }

        opts.autocmds.codecompanion = {
          {
            event = "User",
            pattern = {
              "CodeCompanionRequestStarted",
              "CodeCompanionRequestFinished",
            },
            callback = function(args)
              if args.match == "CodeCompanionRequestStarted" then
                M.start_spinner()
              elseif args.match == "CodeCompanionRequestFinished" then
                M.stop_spinner()
              end
            end,
          },
        }
      end,
    },
    { "AstroNvim/astroui", opts = { icons = { CodeCompanion = "󱚦" } } },
  },
  lazy = true,
  cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionCmd" },
  opts = {
    language = "Chinese",
    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "cmd:pass api_key/gemini",
          },
        })
      end,
      -- copilot = function()
      --   return require("codecompanion.adapters").extend("copilot", {
      --     schema = {
      --       model = {
      --         default = "o4-mini",
      --       },
      --     },
      --   })
      -- end,
      copilot_gemini = function()
        return require("codecompanion.adapters").extend("copilot", {
          name = "copilot_gemini",
          formatted_name = "Copilot Gemini 2.5 Pro",
          schema = {
            model = {
              default = "gemini-2.5-pro",
            },
            max_tokens = {
              default = 128000,
            },
          },
        })
      end,
    },
    display = {
      diff = {
        provider = "mini_diff",
      },
      chat = {
        window = {
          full_height = false,
          width = 0.3,
        },
        show_settings = true,
      },
    },
    strategies = {
      inline = {
        adapter = "copilot",
      },
      chat = {
        roles = {
          llm = function(adapter) return adapter.formatted_name end,
        },
        adapter = "copilot_gemini",
        keymaps = {
          send = { modes = { n = "<M-CR>", i = "<M-CR>" } },
          close = { modes = { n = { "<C-q>", "q" }, i = {} } },
          stop = { modes = { n = "<C-c>" } },
        },
        slash_commands = {
          ["buffer"] = { opts = { provider = "fzf_lua" } },
          ["file"] = { opts = { provider = "fzf_lua" } },
          ["symbols"] = { opts = { provider = "fzf_lua" } },
        },
      },
    },
  },
}
