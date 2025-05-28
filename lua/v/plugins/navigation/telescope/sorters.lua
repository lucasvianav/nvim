local M = {}

local Sorter = require("telescope.sorters").Sorter
local utils = require("v.plugins.navigation.telescope.utils")

---@param opts any
---@param match_shortcut boolean?
function M.funky_fzf(opts, match_shortcut)
  local ok, extension = pcall(function()
    return require("telescope").extensions.fzf
  end)

  if not ok then
    return nil
  end

  local fzf = extension.native_fzf_sorter(opts) --[[@as Sorter]]
  local shortcut_table = match_shortcut and opts.shortcuts or nil

  ---@param prompt string
  ---@return string
  local function process_prompt_for_sorter(prompt)
    local p = utils.process_prompt(prompt, shortcut_table, opts.shortcut_sep)
    local search = p.search or prompt
    local shortcuts = p.shortcuts or {}

    if shortcuts.fzf_tokens and #shortcuts.fzf_tokens > 0 then
      return search .. " " .. vim.iter(shortcuts.fzf_tokens):join(" ")
    end

    return search
  end

  return Sorter:new({
    init = function(self)
      return fzf.init(self)
    end,
    destroy = function(self)
      return fzf.destroy(self)
    end,
    start = function(self, prompt)
      return fzf.start(self, process_prompt_for_sorter(prompt))
    end,
    discard = fzf.discard,
    scoring_function = function(self, prompt, line)
      return fzf.scoring_function(self, process_prompt_for_sorter(prompt), line)
    end,
    highlighter = function(self, prompt, display)
      local p = utils.process_prompt(prompt, nil, opts.shortcut_sep)
      return fzf.highlighter(self, p.search or prompt, display)
    end,
  })
end

function M.highlighter_only(opts)
  local fzy = require("telescope.algos.fzy")
  return Sorter:new({
    scoring_function = function()
      return 1
    end,
    highlighter = function(_, prompt, display)
      local p = utils.process_prompt(prompt, nil, opts.shortcut_sep)
      return fzy.positions(p.search or prompt, display)
    end,
  })
end

---@param opts any
---@param match_shortcut boolean?
function M.funky_fzy(opts, match_shortcut)
  local fzy = require("telescope.algos.fzy")
  local shortcut_table = match_shortcut and opts.shortcuts or nil
  local fzy_offset = -fzy.get_score_floor()

  ---@param prompt string
  ---@return string
  local function process_prompt_for_sorter(prompt)
    local p = utils.process_prompt(prompt, shortcut_table, opts.shortcut_sep)
    local search = p.search or prompt
    local shortcuts = p.shortcuts or {}

    if shortcuts.paths and #shortcuts.paths > 0 then
      search = vim.iter(shortcuts.paths):join(" ") .. " " .. search
    end
    if shortcuts.extensions and #shortcuts.extensions > 0 then
      search = search .. " " .. vim.iter(shortcuts.extensions):join(" ")
    end

    return search
  end

  return Sorter:new({
    scoring_function = function(_, prompt, line)
      local search = process_prompt_for_sorter(prompt)

      -- check for actual matches before running the scoring alogrithm.
      if not fzy.has_match(search, line) then
        return -1
      end

      local fzy_score = fzy.score(search, line)

      -- the fzy score is -inf for empty queries and overlong strings.  since
      -- this function converts all scores into the range (0, 1), we can
      -- convert these to 1 as a suitable "worst score" value.
      if fzy_score == fzy.get_score_min() then
        return 1
      end

      -- poor non-empty matches can also have negative values. offset the score
      -- so that all values are positive, then invert to match the
      -- telescope.sorter "smaller is better" convention. note that for exact
      -- matches, fzy returns +inf, which when inverted becomes 0.
      return 1 / (fzy_score + fzy_offset)
    end,
    highlighter = function(_, prompt, display)
      local p = utils.process_prompt(prompt, nil, opts.shortcut_sep)
      return fzy.positions(p.search or prompt, display)
    end,
    discard = true,
  })
end

return M
