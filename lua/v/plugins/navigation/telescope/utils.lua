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
  }

  for _, shortcut in ipairs(prompt:split()) do
    if not shortcut or #shortcut == 0 then
      goto continue
    end

    local action = shrct_tbl[shortcut]
    local res --- Result of performing the shortcut's action

    if action == nil then
      for regexes, action_it in pairs(shrct_tbl[1]) do
        regexes = type(regexes) == "string" and { regexes } or regexes --[=[@as string[]]=]
        for _, regex_it in ipairs(regexes) do
          if shortcut:match(regex_it) then
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
    elseif type(res) == "string" then
      table.insert(output.globs, res)
    end

    ::continue::
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
  if n_parts > 1 then
    ---@type string
    shortcut_prompt = prompt_parts:pop():trim()
  end

  output.search = prompt_parts:join(shrct_sep)

  if shortcut_prompt and #shortcut_prompt > 0 and shrct_tbl then
    output.shortcuts = process_shortcut_prompt(shortcut_prompt, shrct_tbl)
  end

  return output
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
