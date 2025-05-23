local M = {
  configs = {
    center_dropdown = {
      theme = "dropdown",
      previewer = false,
      layout_strategy = "center",
    },
  },
}

---@param cwd string?
---@return table<string, string>
local function get_rg_gitignore_glob_args(cwd)
  ---@cast cwd string
  cwd = cwd or vim.uv.cwd()
  local gitignore_file = io.open(vim.fs.joinpath(cwd, ".gitignore"), "r")

  if not gitignore_file then
    return {}
  end

  ---@type string
  local gitignore = gitignore_file:read("*a")
  local ignore_globs = vim.tbl_deep_extend("keep", gitignore:gsub("\n+", "\n"):split("\n"), {
    "package-lock.json",
    "yarn.lock",
    "^.git",
    "**/.git",
    "^.git/",
    "**/.git/",
    "^.git/*",
    "**/.git/*",
    "^./.git",
  })

  local ignore_args = {}

  for _, glob in ipairs(ignore_globs) do
    table.insert(ignore_args, "-g")
    table.insert(ignore_args, "!" .. glob)
  end

  return ignore_args
end

---@param options? GrepOptions
function M.multi_grep(options)
  local shortcut_sep = "  "
  local buf_cwd = vim.fn.expand("%:h")
  local shortcuts = {
    ["l"] = "*.lua",
    ["v"] = "*.vim",
    ["n"] = "*.{vim,lua}",
    ["k"] = "*.kt",
    ["x"] = "*.ex",
    ["p"] = "*.proto",
    ["c"] = vim.fs.joinpath(buf_cwd, "**"), -- curr buf's dir
    ["."] = function()
      local path_parts = buf_cwd:split("/")
      return vim.fs.joinpath(path_parts[1], path_parts[2], "**")
    end,
  }

  ---@type {[string|number]: any}
  local opts = vim.tbl_deep_extend("keep", options or {}, {
    cwd = vim.uv.cwd(),
    shortcuts = shortcuts,
    pattern = "%s",
  })

  local custom_grep = require("telescope.finders").new_async_job({
    command_generator = function(prompt)
      ---@type string
      prompt = prompt and prompt:trim() or nil
      if not prompt or #prompt == 0 then
        return nil
      end

      local prompt_parts = prompt:reverse():split(shortcut_sep)
      local n_parts = #prompt_parts
      prompt_parts = vim
        .iter(prompt_parts)
        :map(function(it)
          return it:reverse()
        end)
        :rev()

      local shortcut = nil
      if n_parts > 1 then
        ---@type string
        shortcut = prompt_parts:pop():trim()
      end

      ---@type string
      local search_prompt = prompt_parts:join(shortcut_sep)

      local args = { "rg" }
      if search_prompt then
        table.insert(args, "-e")
        table.insert(args, search_prompt)
      end

      if shortcut and #shortcut > 0 then
        table.insert(args, "-g")

        local pattern = ""
        local action = opts.shortcuts[shortcut]

        if type(action) == "string" then
          pattern = action
        elseif type(action) == "function" then
          pattern = action()
        else
          pattern = shortcut
        end

        table.insert(args, string.format(opts.pattern, pattern))
      end

      return vim
        .iter({
          args,
          get_rg_gitignore_glob_args(opts.cwd),
          {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
        })
        :flatten()
        :totable()
    end,
    entry_maker = require("telescope.make_entry").gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  require("telescope.pickers")
    .new(opts, {
      debounce = 100,
      prompt_title = "~ grep ~",
      finder = custom_grep,
      previewer = require("telescope.config").values.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end

return M
