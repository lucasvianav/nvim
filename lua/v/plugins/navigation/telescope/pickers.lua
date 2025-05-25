local M = {}

local actions = require("telescope.actions")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local utils = require("telescope.utils")
local conf = require("telescope.config").values
local fzf_ok, fzf = pcall(function()
  return require("telescope").extensions.fzf
end)
fzf = fzf_ok and fzf or nil

local ignored = {
  "package-lock.json",
  "yarn.lock",
  ".git",
}

---@param no_gitignore boolean?
---@return table<string, string>
local function get_rg_exclude_glob_flags(no_gitignore)
  local gitig_globs = {}

  if not no_gitignore then
    local gitig_file = io.open(vim.fs.joinpath(vim.uv.cwd(), ".gitignore"), "r")
    gitig_globs = gitig_file and gitig_file:read("*a"):gsub("\n+", "\n"):split("\n") or {}
  end

  local globs = table.merge_lists({
    vim
      .iter(ignored)
      :map(function(it)
        return {
          "**/" .. it .. "/**",
          "**/" .. it .. "",
          "" .. it .. "/**",
          "*" .. it .. "*",
          it,
        }
      end)
      :flatten()
      :totable(),
    gitig_globs,
  })

  return vim
    .iter(globs)
    :map(function(it)
      return { "-g", "!" .. it }
    end)
    :flatten()
    :totable()
end

---@return table<string, string>
local function get_fd_exclude_flags()
  return vim
    .iter(ignored)
    :map(function(it)
      return { "--exclude", it }
    end)
    :flatten()
    :totable()
end

---@param opts table<string, boolean|string|string[]>
---@return string[]
local function get_additional_flags(opts)
  local flags = {
    "--color=never",
    "--hidden",
  }

  if opts.hidden then
    table.insert(flags, "--hidden")
  end
  if opts.no_ignore then
    table.insert(flags, "--no-ignore")
  end
  if opts.no_ignore_parent then
    table.insert(flags, "--no-ignore-parent")
  end
  if opts.follow then
    table.insert(flags, "-L")
  end

  return flags
end

---@return PickerShortcutTable
local function get_shortcut_table()
  local cur_buf = utils.path_expand("%")
  return {
    ["l"] = { glob = "*.lua", extensions = { "lua" } },
    ["v"] = { glob = "*.vim", extensions = { "vim" } },
    ["n"] = { glob = "*.{vim,lua}", extensions = { "lua", "vim" } },
    ["k"] = { glob = "*.kt", extensions = { "kt" } },
    ["x"] = { glob = "*.ex", extensions = { "ex" } },
    ["xs"] = { glob = "*.{ex,exs}", extensions = { "ex", "exs" } },
    ["p"] = { glob = "*.proto", extensions = { "proto" } },
    ["%"] = cur_buf,
    ["."] = { path = utils.path_expand("%:h") }, -- curr buf's dir
    [".."] = { path = utils.path_expand("%:h:h") }, -- curr buf's parent dir
    ["i"] = { flag = "--no-ignore" }, -- include ignored files

    {
      ---Traverse the current buffer's directory in the format `-2p` or `32p`
      ---@param input string
      ["^[+-]?%d+p$"] = function(input)
        local path_parts = utils.path_expand(cur_buf .. ":h"):split("/")
        local parts_it = vim.iter(path_parts)
        local sign, count = input:match("^([+-]?)(%d+)p$")
        local n_dirs = assert(tonumber(count))
        local from_end = sign == "-"
        local res = from_end and parts_it:rskip(n_dirs) or parts_it:take(n_dirs)

        return { path = vim.fs.joinpath(unpack(table.merge_lists(res:totable()))) }
      end,
    },
  }
end

---@param prompt string
---@return PickerProcessedShortcut
local function process_shortcut_prompt(prompt, shortcuts)
  ---@type PickerProcessedShortcut
  local output = {
    globs = {},
    flags = {},
    paths = {},
    extensions = {},
  }

  for _, shortcut in ipairs(prompt:split()) do
    if not shortcut or #shortcut == 0 then
      goto continue
    end

    local glob = ""
    local action = shortcuts[shortcut]
    local shortcut_res

    if action == nil then
      for re, act in pairs(shortcuts[1]) do
        local matches = shortcut:match(re)
        if matches then
          action = act
          break
        end
      end
    end

    if type(action) == "string" or type(action) == "table" then
      shortcut_res = action
    elseif type(action) == "function" then
      shortcut_res = action(shortcut)
    else
      shortcut_res = shortcut
    end

    if type(shortcut_res) == "table" then
      if shortcut_res.flag then
        table.insert(output.flags, shortcut_res.flag)
      end
      if shortcut_res.path then
        table.insert(output.paths, shortcut_res.path)
        glob = vim.fs.joinpath(shortcut_res.path, "**")
      end
      if shortcut_res.glob then
        glob = shortcut_res.glob
      end
      if shortcut_res.extensions and type(shortcut_res.extensions) == "table" then
        for _, it in ipairs(shortcut_res.extensions) do
          table.insert(output.extensions, it)
        end
      end
    elseif type(shortcut_res) == "string" then
      glob = shortcut_res
    end

    if #glob > 0 then
      table.insert(output.globs, glob)
    end

    ::continue::
  end

  return output
end

---@param prompt string
---@param shortcuts PickerShortcutTable
---@param shortcut_sep string
---@return { search: string?, shortcuts: PickerProcessedShortcut? }
local function process_prompt(prompt, shortcuts, shortcut_sep)
  local output = { search = nil, shortcuts = nil }

  ---@type string
  prompt = prompt and prompt:trim() or nil

  if not prompt or #prompt == 0 then
    return output
  end

  local prompt_parts = prompt:reverse():split(shortcut_sep)
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

  output.search = prompt_parts:join(shortcut_sep)

  if shortcut_prompt and #shortcut_prompt > 0 then
    output.shortcuts = process_shortcut_prompt(shortcut_prompt, shortcuts)
  end

  return output
end

---@param prompt string
---@param shortcut_tbl PickerShortcutTable
---@param shortcut_sep string
---@return string[]
local function get_rg_cmd_from_prompt(prompt, shortcut_tbl, shortcut_sep)
  local cmd, p = { "rg" }, process_prompt(prompt, shortcut_tbl, shortcut_sep)

  if not p.search then
    return table.merge_lists(cmd, get_rg_exclude_glob_flags())
  end

  local shortcuts = (p.shortcuts or {})
  local globs = vim
    .iter(shortcuts.globs or {})
    :map(function(it)
      return { "-g", it }
    end)
    :flatten()
    :totable()
  local flags = shortcuts.flags or {}

  return table.merge_lists({
    cmd,
    { "-e", p.search },
    globs,
    flags,
    get_rg_exclude_glob_flags(vim.tbl_contains(flags, "--no-ignore")),
  })
end

---@param prompt string
---@param shortcut_tbl PickerShortcutTable
---@param shortcut_sep string
---@return string[]
local function get_fd_cmd_from_prompt(prompt, shortcut_tbl, shortcut_sep)
  local cmd = { "fd", "--type", "f" }
  local p = process_prompt(prompt, shortcut_tbl, shortcut_sep)

  if not p.search then
    return table.merge_lists(cmd, get_fd_exclude_flags())
  end

  local shortcuts = (p.shortcuts or {})
  local extensions = vim
    .iter(shortcuts.extensions or {})
    :map(function(it)
      return { "--extension", it }
    end)
    :flatten()
    :totable()

  return table.merge_lists({
    cmd,
    p.search,
    shortcuts.paths or {},
    extensions,
    shortcuts.flags or {},
    get_fd_exclude_flags(),
  })
end

---@param options? table
---@return table
local function get_picker_opts(options)
  local opts = vim.tbl_deep_extend("keep", options or {}, {
    cwd = vim.uv.cwd(),
    shortcuts = get_shortcut_table(),
    shortcut_sep = "  ",
    case_mode = "smart_case",
    fuzzy = true,
  })
  opts.cwd = utils.path_expand(opts.cwd)
  return opts
end

---@param options? GrepOptions
function M.multi_grep(options)
  local opts = get_picker_opts(options)
  local custom_grep = require("telescope.finders").new_async_job({
    command_generator = function(prompt)
      return vim
        .iter({
          get_rg_cmd_from_prompt(prompt, opts.shortcuts, opts.shortcut_sep),
          get_additional_flags(opts),
          {
            "--smart-case",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "~ grep ~",
      finder = custom_grep,
      previewer = conf.grep_previewer(opts),
      sorter = fzf and fzf.native_fzf_sorter(opts) or sorters.highlighter_only(opts),
      attach_mappings = function(_, map)
        map("i", "<c-space>", actions.to_fuzzy_refine)
        return true
      end,
      push_cursor_on_edit = true,
    })
    :find()
end

---Calls `rg` when input changes.
---@param options? table
function M.find_files_rg(options)
  local opts = get_picker_opts(options)

  if opts.search_dirs then
    for k, v in pairs(opts.search_dirs) do
      opts.search_dirs[k] = utils.path_expand(v)
    end
  end

  local custom_find_files = require("telescope.finders").new_async_job({
    command_generator = function(prompt)
      return vim
        .iter({
          get_rg_cmd_from_prompt(prompt, opts.shortcuts, opts.shortcut_sep),
          get_additional_flags(opts),
          opts.search_file and { "-g", "*" .. opts.search_file .. "*" } or {},
          { "--files" },
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_file(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "~ find files ~",
      finder = custom_find_files,
      __locations_input = true,
      previewer = conf.grep_previewer(opts),
      sorter = fzf and fzf.native_fzf_sorter(opts) or conf.file_sorter(opts),
    })
    :find()
end

---Calls `fd` when input changes.
---@param options? table
function M.find_files_live_fd(options)
  local opts = get_picker_opts(options)

  if opts.search_dirs then
    for k, v in pairs(opts.search_dirs) do
      opts.search_dirs[k] = utils.path_expand(v)
    end
  end

  local custom_find_files = require("telescope.finders").new_async_job({
    command_generator = function(prompt)
      return vim
        .iter({
          get_fd_cmd_from_prompt(prompt, opts.shortcuts, opts.shortcut_sep),
          get_fd_exclude_flags(),
          get_additional_flags(opts),
          opts.search_file and { opts.search_file } or {},
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_file(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "~ find files ~",
      finder = custom_find_files,
      __locations_input = true,
      previewer = conf.grep_previewer(opts),
      sorter = fzf and fzf.native_fzf_sorter(opts) or sorters.highlighter_only(opts),
    })
    :find()
end

---Does not call `fd` when input changes. Just calls it once and sorts.
---@param options? table
function M.find_files_fd(options)
  local opts = get_picker_opts(options)

  if opts.search_dirs then
    for k, v in pairs(opts.search_dirs) do
      opts.search_dirs[k] = utils.path_expand(v)
    end
  end

  opts.entry_maker = make_entry.gen_from_file(opts)

  local cmd = vim
    .iter({
      get_fd_cmd_from_prompt("", { {} }, ""),
      get_fd_exclude_flags(),
      get_additional_flags(opts),
      opts.search_file and { opts.search_file } or {},
    })
    :flatten()
    :totable()

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "~ find files ~",
      finder = require("telescope.finders").new_oneshot_job(cmd, opts),
      __locations_input = true,
      previewer = conf.grep_previewer(opts),
      sorter = fzf and fzf.native_fzf_sorter(opts) or sorters.highlighter_only(opts),
    })
    :find()
end

return M
