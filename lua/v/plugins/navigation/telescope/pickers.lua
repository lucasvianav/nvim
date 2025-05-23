local M = {
  configs = {
    center_dropdown = {
      theme = "dropdown",
      previewer = false,
      layout_strategy = "center",
    },
  },
}

---@return table<string, string>
local __get_rg_gitignore_glob_args = function()
  local gitignore_path = vim.fs.joinpath(vim.loop.cwd(), ".gitignore")
  local gitignore_file = io.open(gitignore_path, "r")

  if gitignore_file == nil then
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
M.multi_grep = function(options)
  local buf_cwd = vim.fn.expand("%:h")
  local shortcuts = {
    ["l"] = "*.lua",
    ["v"] = "*.vim",
    ["n"] = "*.{vim,lua}",
    ["k"] = "*.kt",
    ["p"] = "*.proto",
    ["c"] = vim.fs.joinpath(buf_cwd, "**"),
    ["."] = function()
      local path_parts = buf_cwd:split("/")
      return vim.fs.joinpath(path_parts[1], path_parts[2], "**")
    end,
  }

  ---@type table<string|number, any>
  local opts = vim.tbl_deep_extend("keep", options or {}, {
    cwd = vim.loop.cwd(),
    shortcuts = shortcuts,
    pattern = "%s",
  })

  local custom_grep = require("telescope.finders").new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local prompt_split = vim.split(prompt, "  ")

      local args = { "rg" }
      if prompt_split[1] then
        table.insert(args, "-e")
        table.insert(args, prompt_split[1])
      end

      -- patterns
      if prompt_split[2] then
        table.insert(args, "-g")

        local pattern
        if type(opts.shortcuts[prompt_split[2]]) == "string" then
          pattern = opts.shortcuts[prompt_split[2]]
        elseif type(opts.shortcuts[prompt_split[2]]) == "function" then
          pattern = opts.shortcuts[prompt_split[2]]()
        else
          pattern = prompt_split[2]
        end

        table.insert(args, string.format(opts.pattern, pattern))
      end

      return vim
        .iter({
          args,
          __get_rg_gitignore_glob_args(),
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
