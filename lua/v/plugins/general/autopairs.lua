local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")

npairs.setup({
  disable_filetype = { "TelescopePrompt" },
  ignored_next_char = string.gsub([[ [%w%%%'%[%'%.] ]], "%s+", ""),
  enable_moveright = true,
  enable_afterquote = true, -- add bracket pairs after quote
  enable_check_bracket_line = true, -- check bracket in same line
  map_bs = true, -- <BS>
  check_ts = true,
})

-- endwise
npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))

-- add spaces between parenthesis
npairs.add_rules({
  Rule(" ", " "):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({ "()", "[]", "{}" }, pair)
  end),
  Rule("( ", " )")
    :with_pair(function()
      return false
    end)
    :with_move(function(opts)
      return opts.prev_char:match(".%)") ~= nil
    end)
    :use_key(")"),
  Rule("{ ", " }")
    :with_pair(function()
      return false
    end)
    :with_move(function(opts)
      return opts.prev_char:match(".%}") ~= nil
    end)
    :use_key("}"),
  Rule("[ ", " ]")
    :with_pair(function()
      return false
    end)
    :with_move(function(opts)
      return opts.prev_char:match(".%]") ~= nil
    end)
    :use_key("]"),
})
