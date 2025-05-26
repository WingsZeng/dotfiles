-- TODO: bs overjumps
return {
  "altermo/ultimate-autopair.nvim",
  opts = {
    cr = {
      autoclose = true,
    },
    config_internal_pairs = {
      { "[", "]", suround = true },
      { "(", ")", suround = true },
      { "{", "}", suround = true },
      { '"', '"', dosuround = true },
      { "'", "'", dosuround = true },
      { "`", "`", dosuround = true },
      { "``", "''", dosuround = true },
    },
  },
  config = function(_, opts)
    local ua = require "ultimate-autopair"
    local config = ua.extend_default(opts)

    local default = require "ultimate-autopair.profile.default.utils"
    local open_pair = require "ultimate-autopair.profile.default.utils.open_pair"
    local utils = require "ultimate-autopair.utils"

    -- HACK: redefine the surround check function to add support for this word surround
    require("ultimate-autopair.extension.suround").check = function(o, m)
      local pconf = m.conf
      ---@cast pconf ext.suround.pconf
      if not default.orof(pconf.dosuround, o, m, true) then return end
      local pair, index, rindex = default.get_pair_and_end_pair_pos_from_start(
        o,
        o.col,
        nil,
        function(p) return default.orof(p.conf.suround, o, m, true) end
      )
      -- if not pair or (not default.orof(pair.multiline,o,pair,true) and rindex~=o.row) then return end
      if not m.fn.can_check_pre(o) then return end
      if open_pair.open_end_pair_after(m, o, o.col - #m.pair + 1) then return end
      if not (not pair or (not default.orof(pair.multiline, o, pair, true) and rindex ~= o.row)) then
        return utils.create_act {
          { "j", rindex - o.row },
          { "home" },
          { "l", index + #pair.end_pair - 1 },
          m.end_pair,
          { "k", rindex - o.row },
          { "home" },
          { "l", o.col - 1 },
          m.pair:sub(-1),
        }
      else
        local function utf8_iter(str)
          local i = 1
          local len = #str
          return function()
            if i > len then return nil end
            local c = str:byte(i)

            local bytes = 1
            if c >= 0xF0 then
              bytes = 4
            elseif c >= 0xE0 then
              bytes = 3
            elseif c >= 0xC0 then
              bytes = 2
            end

            local ch = str:sub(i, i + bytes - 1)
            i = i + bytes
            return ch
          end
        end

        -- 判断是否为“单词字符”：ASCII word 或 汉字（可扩展）
        local function is_word_char(ch)
          local b = { ch:byte(1, -1) }
          local code = 0
          for i = 1, #b do
            code = code * 256 + b[i]
          end

          return ch:match "[%w_]" -- ASCII [a-zA-Z0-9_]
            or (code >= 0xE4B880 and code <= 0xE9BEA5) -- 粗略匹配汉字 (UTF-8 encoded)
        end

        -- 提取 UTF-8 “word”
        local function get_utf8_word(str)
          local word = {}
          for ch in utf8_iter(str) do
            if is_word_char(ch) then
              table.insert(word, ch)
            else
              break
            end
          end
          return table.concat(word)
        end

        -- local word = o.line:sub(o.col):match "^%S+"
        local word = get_utf8_word(o.line:sub(o.col))
        if not word then return end

        local word_len = #word
        while true do
          local col_end = o.col + word_len - 1
          pair, index, rindex = default.get_pair_and_start_pair_pos_from_end(o, col_end)
          if not pair or rindex ~= o.row or index >= o.col then break end
          word_len = word_len - #pair.end_pair
        end
        word = word:sub(1, word_len)

        return utils.create_act {
          m.pair:sub(-1),
          { "l", #word },
          m.end_pair,
          { "h", #word + 1 },
        }
      end
    end

    vim.list_extend(config, {
      { "$", "$", ft = { "markdown" }, fly = true, dosuround = true, space = true, bs_overjumps = true },
      {
        "$$",
        "$$",
        ft = { "tex", "markdown" },
        fly = true,
        dosuround = true,
        space = true,
        newline = true,
        multiline = true,
        alpha_after = true,
      },
      { "*", "*", ft = { "markdown", "typ" }, dosuround = true, alpha = true },
      { "**", "**", ft = { "markdown" }, dosuround = true, alpha = true, alpha_after = true },
      { "_", "_", ft = { "markdown", "typ" }, dosuround = true, alpha = true },
      { "__", "__", ft = { "markdown" }, dosuround = true, alpha = true, alpha_after = true },
    })
    ua.init { config }
  end,
}
