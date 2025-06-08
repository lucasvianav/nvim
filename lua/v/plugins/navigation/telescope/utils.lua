local M = {}

local fzf_ok, fzf = pcall(function()
  return require("telescope").extensions.fzf
end)
fzf = fzf_ok and fzf or nil

---@param path string
---@return string
M.path_expand = function(path)
  return vim.fs.abspath(require("telescope.utils").path_expand(path))
end

---@param path string
---@return string
M.path_expand_rel_to_cwd = function(path)
  local abs_path = M.path_expand(path)
  local cwd = vim.uv.cwd()
  local rel_path = cwd and vim.fs.relpath(M.path_expand(cwd), abs_path)
  return rel_path or abs_path
end

---@param prompt string
---@param shrct_tbl PickerShortcutTable
---@return PickerProcessedShortcut
local function process_shortcut_prompt(prompt, shrct_tbl)
  ---@type PickerProcessedShortcut
  local output = {
    globs = {},
    flags = {},
    paths = {},
    extensions = {},
    fzf_tokens = {},
    debug = {},
    regex = "",
  }
  local output_regexes, parts = {}, {}

  -- local p = [[r=%< \S+%> @p r=%< \S+%> 2p+ r=%< \S+%>]]

  -- this pattern is a shortcut that can have spaces within it
  local pat = "%%<[^(%>)]-%%>"
  local stripped_prompt = table.join(prompt:split("%s?" .. pat .. "%s?"), " ") or ""
  for it in prompt:gmatch(pat) do
    table.insert(parts, it)
  end
  for _, it in ipairs(stripped_prompt:trim():split()) do
    table.insert(parts, it)
  end

  for _, shortcut in ipairs(parts) do
    if not shortcut or #shortcut == 0 then
      goto continue
    end

    local action = shrct_tbl[shortcut]
    local res --- Result of performing the shortcut's action

    if action == nil then
      for pats, action_it in pairs(shrct_tbl[1]) do
        pats = type(pats) == "string" and { pats } or pats --[=[@as string[]]=]
        for _, pat_it in ipairs(pats) do
          if shortcut:match(pat_it) then
            action = action_it
            break
          end
        end
      end
    end

    if type(action) == "table" then
      res = action
    elseif type(action) == "function" then
      res = action(shortcut)
    else
      res = shortcut
    end

    if type(res) == "table" then
      -- flags
      if res.flag then
        table.insert(output.flags, res.flag)
      end
      if res.flags then
        for _, it in ipairs(res.flags) do
          table.insert(output.flags, it)
        end
      end

      -- paths
      if res.path then
        table.insert(output.paths, res.path)
        table.insert(output.globs, vim.fs.joinpath(res.path, "**"))
        table.insert(output.fzf_tokens, res.path)
      end

      --globs
      if res.glob then
        table.insert(output.globs, res.glob)
      end

      --globs
      if res.fzf_token then
        table.insert(output.fzf_tokens, res.fzf_token)
      end

      -- extensions
      if res.extension then
        table.insert(output.extensions, res.extension)
        table.insert(output.globs, "*." .. res.extension)
        table.insert(output.fzf_tokens, "." .. res.extension .. "$")
      end
      if res.extensions then
        for _, it in ipairs(res.extensions) do
          table.insert(output.extensions, it)
          table.insert(output.globs, "*." .. it)
          table.insert(output.fzf_tokens, "." .. it .. "$")
        end
      end

      -- debug
      if res.debug then
        table.insert(output.debug, res.debug == true and "parser" or res.debug)
      end

      -- regex
      if res.regex and #res.regex > 0 then
        table.insert(output_regexes, res.regex)
      end
    elseif type(res) == "string" then
      table.insert(output.globs, res)
    end

    ::continue::
  end

  -- parse FZF tokens into search syntax
  -- https://github.com/junegunn/fzf?tab=readme-ov-file#search-syntax
  if #output.fzf_tokens > 0 then
    local leading, trailing, match = {}, {}, {}

    for _, token in ipairs(output.fzf_tokens) do
      if token:starts_with("^") then
        table.insert(leading, token)
      elseif token:ends_with("$") and not token:starts_with("!") then
        table.insert(trailing, token)
      else
        table.insert(match, token)
      end
    end

    output.fzf_tokens = table.merge_lists({
      table.join(leading, " | ") or {},
      match,
      table.join(trailing, " | ") or {},
    })
  end

  if #output_regexes == 1 then
    output.regex = output_regexes[1]
  elseif #output_regexes > 1 then
    output.regex = ("(%s)"):format(table.join(output_regexes, "|"))
  end

  if vim.tbl_contains(output.debug, "parser_shortcut_parts") then
    P(parts)
  end

  return output
end

---@param prompt string
---@param shrct_tbl PickerShortcutTable?
---@param shrct_sep string? default "  "
---@return { search: string?, shortcuts: PickerProcessedShortcut? }
function M.process_prompt(prompt, shrct_tbl, shrct_sep)
  local output = { search = nil, shortcuts = nil }

  shrct_sep = shrct_sep or "  "

  if not prompt or #prompt == 0 then
    return output
  end

  local prompt_parts = prompt:reverse():split(shrct_sep)
  local n_parts = #prompt_parts
  prompt_parts = vim
    .iter(prompt_parts)
    :map(function(it)
      return it:reverse()
    end)
    :rev()

  local shortcut_prompt = nil
  if n_parts > 1 or (n_parts == 1 and prompt:starts_with(shrct_sep)) then
    ---@type string
    shortcut_prompt = prompt_parts:pop():trim()
  end

  output.search = prompt_parts:join(shrct_sep)

  if shortcut_prompt and #shortcut_prompt > 0 and shrct_tbl then
    output.shortcuts = process_shortcut_prompt(shortcut_prompt, shrct_tbl)
  end

  return PC(vim.tbl_contains((output.shortcuts or {}).debug or {}, "parser"), output)
end

---Traverse the file's path/parent directories
---@param filepath string
---@param n_dirs integer
---@param direction "left"|"right"
---@return string path
function M.traverse_parents(filepath, n_dirs, direction)
  local path_parts = vim.fs.dirname(filepath):split("/")
  local parts_it = vim.iter(path_parts)
  local res ---@type Iter

  if direction == "right" then
    res = parts_it:rskip(math.min(n_dirs, #path_parts - 1))
  else
    res = parts_it:take(math.max(n_dirs, 1))
  end

  return vim.fs.joinpath(unpack(res:totable()))
end

return M
