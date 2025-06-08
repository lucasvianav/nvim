local M = {}

local actions = require("telescope.actions")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local v = {
  actions = require("v.plugins.navigation.telescope.actions"),
  sorters = require("v.plugins.navigation.telescope.sorters"),
  utils = require("v.plugins.navigation.telescope.utils"),
}

-- TODO: directory fd and rg pickers to be used in oil buffers to open another directory

local ignored = {
  "package-lock.json",
  "yarn.lock",
  ".git",
  ".gitignore",
  "spell/",
}

---@return PickerShortcutTable
local function get_shortcut_table()
  local cur_buf = v.utils.path_expand_rel_to_cwd("%")
  local cur_buf_dir = vim.fs.dirname(cur_buf)

  ---@type PickerShortcutTable
  return {
    ["l"] = { extension = "lua" },
    ["v"] = { extension = "vim" },
    ["k"] = { glob = "!*Test.kt", fzf_token = "!Test.kt$", extension = "kt" },
    ["kt"] = { extension = "kt" },
    ["h"] = { extension = "html" },
    ["c"] = { extension = "css" },
    ["t"] = { extensions = { "ts", "tsx" } },
    ["j"] = { extensions = { "js", "jsx" } },
    ["r"] = { extensions = { "tsx", "jsx" } },
    ["x"] = { extension = "ex" },
    ["xs"] = { extensions = { "ex", "exs" } },
    ["p"] = { extensions = { "proto" } },
    ["%"] = { glob = cur_buf, fzf_token = cur_buf },
    ["."] = { path = cur_buf_dir }, -- curr buf's dir
    [".."] = { path = vim.fs.dirname(cur_buf_dir) }, -- curr buf's parent dir
    ["i"] = { flag = "--no-ignore" }, -- include ignored files
    ["I"] = { flag = "--case-sensitive" }, -- include ignored files

    -- debuggers
    ["@pp"] = { debug = "parser_shortcut_parts" },
    ["@p"] = { debug = "parser" },
    ["@s"] = { debug = "sorter" },
    ["@f"] = { debug = "finder" },

    {
      ["^%%<[^(%>)]-%%>$"] = function(input)
        local regex = input:match("^%%<([^(%>)]-)%%>$")
        return { regex = regex }
      end,

      ---Traverse the current buffer's directory (p2-, p-2, 2p-, 2-p, -2p, -p2, 3p, p3)
      [{ "^p[+-]?%d+[+-]?$", "^[+-]?%d+p[+-]?$", "^%d+[+-]?p$", "[+-]?p^%d+$" }] = function(input)
        local sign_1, count, sign_2 = input:match("^p?([+-]?)(%d+)p?([+-]?)p?$")
        local n_dirs = assert(tonumber(count))
        local sign = sign_1 and #sign_1 > 0 and sign_1 or sign_2

        if sign_1 and #sign_1 > 0 and sign_2 and #sign_2 > 0 then
          return nil
        end

        local path = v.utils.traverse_parents(cur_buf, n_dirs, sign == "-" and "right" or "left")
        return { path = path }
      end,
    },
  }
end

---@param no_gitignore boolean?
---@return table<string, string>
local function get_rg_exclude_glob_flags(no_gitignore)
  --TODO: https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#hide-gitignored-files-and-show-git-tracked-hidden-files
  local gitig_globs, gitig_path = {}, nil

  if not no_gitignore then
    gitig_path = vim.fs.joinpath(vim.uv.cwd(), ".gitignore")
    local gitig_file = io.open(gitig_path, "r")

    if gitig_file then
      gitig_globs = gitig_file:read("*a"):gsub("\n+", "\n"):split("\n")
    else
      gitig_path = nil
    end
  end

  local globs = table.merge_lists({
    vim
      .iter(ignored)
      :map(function(it)
        return {
          vim.fs.joinpath("**", it, "**"),
          vim.fs.joinpath(it, "**"),
          vim.fs.joinpath("*", it, "*"),
          it,
        }
      end)
      :flatten()
      :totable(),
    gitig_globs,
  })

  local res_globs = vim
    .iter(globs)
    :map(function(it)
      return { "-g", "!" .. it }
    end)
    :flatten()
    :totable()

  return gitig_path
      and table.merge_lists("--ignore-file=" .. vim.fs.basename(gitig_path), res_globs)
    or res_globs
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

---@param shortcut_tbl PickerShortcutTable
---@param shortcut_sep string?
---@return string[], string[]?
local function get_rg_cmd_from_prompt(prompt, shortcut_tbl, shortcut_sep)
  local cmd, p = { "rg" }, v.utils.process_prompt(prompt, shortcut_tbl, shortcut_sep)
  local shortcuts = (p.shortcuts or {})

  if not p.search and not shortcuts.regex then
    return table.merge_lists(cmd, get_rg_exclude_glob_flags()) --[=[@as string[]]=]
  end

  local globs = vim
    .iter(shortcuts.globs or {})
    :map(function(it)
      return { "-g", it }
    end)
    :flatten()
    :totable()
  local flags = shortcuts.flags or {}

  local res = table.merge_lists({ ---@type string[]
    cmd,
    { "-e", (p.search or "") .. (shortcuts.regex or "") },
    #globs > 0 and globs or { "-g", "**" },
    get_rg_exclude_glob_flags(vim.tbl_contains(flags, "--no-ignore")),
  })

  return PC(vim.tbl_contains(shortcuts.debug or {}, "finder"), res), flags
end

---@param prompt string
---@param shortcut_tbl PickerShortcutTable
---@param shortcut_sep string?
---@param dirs boolean?
---@return string[], string[]?
local function get_fd_cmd_from_prompt(prompt, shortcut_tbl, shortcut_sep, dirs)
  local cmd = { "fd", "--type", dirs and "d" or "f", "--full-path" }
  local p = v.utils.process_prompt(prompt, shortcut_tbl, shortcut_sep)
  local shortcuts = (p.shortcuts or {})

  if not p.search and not shortcuts.regex then
    return table.merge_lists(cmd, get_fd_exclude_flags())
  end

  local extensions = vim
    .iter(shortcuts.extensions or {})
    :map(function(it)
      return { "--extension", it }
    end)
    :flatten()
    :totable()
  local res = table.merge_lists({
    cmd,
    (p.search or "") .. (shortcuts.regex or ""),
    shortcuts.paths or {},
    extensions,
    get_fd_exclude_flags(),
  })

  return PC(vim.tbl_contains(shortcuts.debug or {}, "finder"), res), shortcuts.flags
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
  opts.cwd = v.utils.path_expand(opts.cwd)
  return opts
end

---@param options? GrepOptions
function M.multi_grep(options)
  local opts = get_picker_opts(options)
  local custom_grep = require("telescope.finders").new_async_job({
    command_generator = function(prompt)
      local cmd, flags = get_rg_cmd_from_prompt(prompt, opts.shortcuts, opts.shortcut_sep)
      return vim
        .iter({
          cmd,
          get_additional_flags(opts),
          {
            "--smart-case",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          flags,
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
      sorter = v.sorters.funky_fzf(opts) or v.sorters.funky_fzy(opts),
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
    for dir, path in pairs(opts.search_dirs) do
      opts.search_dirs[dir] = v.utils.path_expand(path)
    end
  end

  local custom_find_files = require("telescope.finders").new_async_job({
    command_generator = function(prompt)
      local cmd, flags = get_rg_cmd_from_prompt(prompt, opts.shortcuts, opts.shortcut_sep)
      return vim
        .iter({
          cmd,
          get_additional_flags(opts),
          opts.search_file and { "-g", "*" .. opts.search_file .. "*" } or {},
          flags,
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
      previewer = conf.file_previewer(opts),
      sorter = v.sorters.funky_fzf(opts) or conf.file_sorter(opts),
    })
    :find()
end

---Calls `fd` when input changes.
---@param options? table
function M.find_files_live_fd(options)
  local opts = get_picker_opts(options)
  local dirs = opts.dirs
  opts.dirs = nil

  if opts.search_dirs then
    for dir, path in pairs(opts.search_dirs) do
      opts.search_dirs[dir] = v.utils.path_expand(path)
    end
  end

  local custom_find_files = require("telescope.finders").new_async_job({
    command_generator = function(prompt)
      return vim
        .iter({
          get_fd_cmd_from_prompt(prompt, opts.shortcuts, opts.shortcut_sep, dirs),
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
      prompt_title = ("~ (live) find %s ~"):format(dirs and "directories" or "files"),
      finder = custom_find_files,
      __locations_input = true,
      previewer = conf.file_previewer(opts),
      sorter = v.sorters.funky_fzf(opts) or v.sorters.funky_fzy(opts),
      attach_mappings = function(_, map)
        map("i", "<c-space>", actions.to_fuzzy_refine)
        return true
      end,
      push_cursor_on_edit = true,
    })
    :find()
end

---Does not call `fd` when input changes. Just calls it once and sorts.
---@param options? table
function M.find_files_fd(options)
  local opts = get_picker_opts(options)
  local dirs = opts.dirs
  opts.dirs = nil

  if opts.search_dirs then
    for dir, path in pairs(opts.search_dirs) do
      opts.search_dirs[dir] = v.utils.path_expand(path)
    end
  end

  opts.entry_maker = make_entry.gen_from_file(opts)

  local cmd = vim
    .iter({
      get_fd_cmd_from_prompt("", { {} }, "", dirs),
      get_fd_exclude_flags(),
      get_additional_flags(opts),
      opts.search_file and { opts.search_file } or {},
    })
    :flatten()
    :totable()

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = ("~ find %s ~"):format(dirs and "directories" or "files"),
      finder = require("telescope.finders").new_oneshot_job(cmd, opts),
      __locations_input = true,
      previewer = conf.file_previewer(opts),
      sorter = v.sorters.funky_fzf(opts, true) or v.sorters.funky_fzy(opts),
      attach_mappings = function(_, map)
        if dirs then
          for _, mode in ipairs({ "n", "i" }) do
            map(mode, "<cr>", v.actions.open_with_oil)
            map(mode, "<c-t>", v.actions.open_with_oil("tab"))
            map(mode, "<c-s>", v.actions.open_with_oil("hor"))
            map(mode, "<c-h>", v.actions.open_with_oil("hor"))
            map(mode, "<c-v>", v.actions.open_with_oil("vert"))
          end
        end
        return true
      end,
    })
    :find()
end

return M
