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
    { "ravitemer/codecompanion-history.nvim" },
    { "ravitemer/mcphub.nvim" },
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
            vim.cmd "CodeCompanion"
            vim.defer_fn(function()
              local keys = vim.api.nvim_replace_termcodes("#{buffer} ", true, false, true)
              vim.api.nvim_feedkeys(keys, "i", false)
            end, 10)
          end,
          desc = "Prompt Inline (prefill #{buffer})",
        }
        maps.v[prefix .. "i"] = { ":CodeCompanion<CR>", desc = "Prompt Inline" }
        maps.v[prefix .. "e"] = { function() codecompanion.prompt "explain" end, desc = "Explain Code" }
        maps.v[prefix .. "f"] = { function() codecompanion.prompt "fix" end, desc = "Fix Code" }
        maps.n[prefix .. "l"] = { function() codecompanion.prompt "lsp" end, desc = "Explain LSP Diagnostics" }
        maps.n[prefix .. "m"] = { function() codecompanion.prompt "commit" end, desc = "Generate Commit Message" }
        maps.v[prefix .. "t"] = { function() codecompanion.prompt "tests" end, desc = "Generate Unit Tests" }
        maps.v[prefix .. "/"] = { function() codecompanion.prompt "comments" end, desc = "Generate Comments" }
        maps.v[prefix .. "r"] = { function() codecompanion.prompt "refactor" end, desc = "Refactor Code" }

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
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "o4-mini",
            },
          },
        })
      end,
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
          send = { modes = { n = "<CR>", i = {} } },
          close = { modes = { n = { "<C-q>", "q" }, i = {} } },
          stop = { modes = { n = "<C-c>" } },
          system_prompt = { modes = { n = {} } },
        },
        slash_commands = {
          ["buffer"] = { opts = { provider = "fzf_lua" } },
          ["file"] = { opts = { provider = "fzf_lua" } },
          ["symbols"] = { opts = { provider = "fzf_lua" } },
        },
        tools = {
          opts = {
            wait_timeout = 86400000,
          },
        },
      },
    },
    prompt_library = {
      ["Refactor Code"] = {
        strategy = "inline",
        description = "Refactor and optimize the selected code",
        opts = {
          modes = { "v" },
          short_name = "refactor",
          auto_submit = true,
          user_prompt = false,
        },
        prompts = {
          {
            role = "system",
            content = [[When asked to refactor and optimize code, follow these steps:

1.  **Analyze & Understand**:
    * Identify the programming language of the provided code snippet.
    * Thoroughly understand its current functionality to ensure external behavior can be strictly preserved during refactoring.

2.  **Refactor & Optimize**:
    * Systematically improve the code's internal structure, performance, readability, and maintainability.
    * Apply established refactoring techniques and best practices appropriate for the identified language.

3.  **Prepare Final Code**:
    * Construct a single markdown code block containing *only* the refactored code.
    * Ensure the programming language is specified at the start of the code block (e.g., ```python or ```lua).

Important: The response must *not* include any explanations of the changes, surrounding text, conversational remarks, or additional comments outside of the code itself that describe the refactoring process.

Ensure the refactored code exhibits the following qualities:

-   **Behavioral Equivalence**: The refactored code must behave externally identically to the original code.
-   **Improved Structure**: Enhanced organization, clear abstraction, proper encapsulation, and be a complete replacement for the original snippet within its existing context.
-   **Optimized Performance**: Utilization of more efficient algorithms and data structures where applicable, without altering external behavior.
-   **Enhanced Readability**: Clear, concise, and idiomatic code following language-specific style conventions.
-   **Maintainability**: Code that is easier to understand, modify, and debug. This includes the use of descriptive naming conventions.
-   **DRY Principle**: Elimination of significant code duplication.
-   **Modern Practices**: Adherence to modern syntax and established best practices of the programming language.
-   **Resource Consciousness**: Efficient use of resources, where relevant to the provided snippet.
]],
            opts = {
              visible = false,
            },
          },
          {
            role = "user",
            content = function(context)
              local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

              return string.format(
                [[Please refactor and optimize the following %s code from buffer %d.
The code to refactor is:


```%s
%s
```
]],
                context.filetype,
                context.bufnr,
                context.filetype,
                code
              )
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
      ["Add Comments"] = {
        strategy = "inline",
        description = "Add high-level comments and remove low-level comments.",
        opts = {
          modes = { "v" },
          short_name = "comments",
          auto_submit = true,
          user_prompt = false,
        },
        prompts = {
          {
            role = "system",
            content = [[When asked to manage code comments, follow these steps:

1. **Add High-Level Comments**: Insert documentation comments (like docstrings or header comments) for classes and functions, clearly stating their purpose, expected inputs, and outputs.
2. **Remove Low-Level/Redundant Comments**: Delete any comments that state the obvious, repeat the code, or are outdated/irrelevant.
3. **Follow Convention**: Ensure all added comments follow the standard conventions for the relevant programming language.
4. **Preserve Code Structure**: Do not change the code's logic, structure, or naming. Only modify comments.
5. **Keep Special Comments**: If there are comments with prefixes like `TODO:`, `HACK:`, `FIX:`, `BUG:` etc., keep them in their relevant position as they usually mark important pending work or known issues.

Your response must be a single markdown code block (with the programming language specified) containing only the updated code.]],
            opts = {
              visible = false,
            },
          },
          {
            role = "user",
            content = function(context)
              local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

              return string.format(
                [[Please improve the comments in this code from buffer %d according to best practices:

```%s
%s
```
]],
                context.bufnr,
                context.filetype,
                code
              )
            end,
            opts = { contains_code = true },
          },
        },
      },
    },
    extensions = {
      history = {
        enabled = true,
        opts = {
          -- Keymap to open history from chat buffer (default: gh)
          keymap = "gh",
          -- Keymap to save the current chat manually (when auto_save is disabled)
          save_chat_keymap = "gs",
          -- Save all chats by default (disable to save only manually using 'sc')
          auto_save = false,
          -- Number of days after which chats are automatically deleted (0 to disable)
          expiration_days = 0,
          -- Picker interface (auto resolved to a valid picker)
          picker = "fzf-lua",
          ---Automatically generate titles for new chats
          auto_generate_title = true,
          -- title_generation_opts = {
          --   ---Adapter for generating titles (defaults to current chat adapter)
          --   adapter = nil, -- "copilot"
          --   ---Model for generating titles (defaults to current chat model)
          --   model = nil, -- "gpt-4o"
          --   ---Number of user prompts after which to refresh the title (0 to disable)
          --   refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
          --   ---Maximum number of times to refresh the title (default: 3)
          --   max_refreshes = 3,
          -- },
          ---On exiting and entering neovim, loads the last chat on opening chat
          continue_last_chat = false,
          ---When chat is cleared with `gx` delete the chat from history
          -- delete_on_clearing_chat = false,
          ---Directory path to save the chats
          dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
          ---Enable detailed logging for history extension
          -- enable_logging = false,
        },
      },
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          -- MCP Tools
          make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true, -- Show tool results directly in chat buffer
          format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = true, -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true, -- Add MCP prompts as /slash commands
        },
      },
    },
  },
}
