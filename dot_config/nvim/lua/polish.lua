-- Checks if the current window is the only real window open.
-- A "real" window is defined as a focusable window with an empty 'buftype'.
local function is_current_only_real_windows()
  -- Helper function to determine if a given window ID corresponds to a "real" window.
  local function is_real_window(win_id)
    if not win_id or not vim.api.nvim_win_is_valid(win_id) then return false end
    local buf = vim.api.nvim_win_get_buf(win_id)
    if not vim.api.nvim_buf_is_valid(buf) then return false end
    local buftype = vim.bo[buf].buftype
    local config = vim.api.nvim_win_get_config(win_id)
    return config.focusable and buftype == ""
  end

  local all_wins = vim.api.nvim_list_wins()
  local real_wins = vim.tbl_filter(is_real_window, all_wins)

  local current_win_id = vim.api.nvim_get_current_win()
  local current_win_is_real = vim.tbl_contains(real_wins, current_win_id)

  return #real_wins == 1 and current_win_is_real
end

-- Creates a custom command (e.g., Q, WQ, X) that behaves like 'qa' (quit all)
-- if the current window is the only real window, otherwise behaves like the base command (e.g., q, wq, x).
-- It also sets up a command-line abbreviation for the lowercase version of the command.
local function create_quit_command(base_cmd_char)
  local cmd_name = string.upper(base_cmd_char)
  local lower_base_cmd = string.lower(base_cmd_char)

  vim.api.nvim_create_user_command(cmd_name, function(opts)
    local bang_suffix = opts.bang and "!" or ""
    if is_current_only_real_windows() then
      vim.cmd(lower_base_cmd .. "a" .. bang_suffix) -- Quit all if it's the last real window
    else
      vim.cmd(lower_base_cmd .. bang_suffix) -- Otherwise, quit current window
    end
  end, {
    bang = true, -- Allows for '!' to be used (e.g., Q!)
    nargs = 0, -- Command takes no arguments
  })

  -- Create a command-line abbreviation.
  -- For example, typing ':q' and then a space/enter will expand to ':Q' if it's the only thing on the command line.
  local cnoreabbrev_cmd = string.format(
    "cnoreabbrev <expr> %s (getcmdtype() == ':' && getcmdline() ==# '%s') ? '%s' : '%s'",
    lower_base_cmd,
    lower_base_cmd,
    cmd_name,
    lower_base_cmd
  )
  vim.cmd(cnoreabbrev_cmd)
end

-- Create the custom quit commands.
create_quit_command "q"
create_quit_command "wq"
create_quit_command "x"
