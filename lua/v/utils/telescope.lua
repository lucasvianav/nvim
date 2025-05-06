local actions = require('telescope.actions')
local state = require('telescope.actions.state')

---@return table<string, string>
local __get_rg_gitignore_glob_args = function ()
  local gitignore_path = vim.fs.joinpath(vim.loop.cwd(), '.gitignore')
  local gitignore_file = io.open(gitignore_path, 'r')

  if gitignore_file == nil then
    return {}
  end

  ---@type string
  local gitignore = gitignore_file:read('*a')
  local ignore_globs = vim.tbl_deep_extend(
    'keep',
    gitignore:gsub("\n+", "\n"):split('\n'),
    {
      'package-lock.json',
      'yarn.lock',
      '^.git',
      '**/.git',
      '^.git/',
      '**/.git/',
      '^.git/*',
      '**/.git/*',
      '^./.git',
    }
  )

  local ignore_args = {}

  for _, glob in ipairs(ignore_globs) do
    table.insert(ignore_args, '-g')
    table.insert(ignore_args, "!" .. glob)
  end

  return ignore_args
end

local M = {}

M.open_in_diff = function(prompt_bufnr)
  actions.close(prompt_bufnr)
  local commit_hash = state.get_selected_entry().value

  local ok_packer, packer = require('v.utils.packer').get_packer()

  if ok_packer then
    pcall(packer.loader, 'diffview.nvim')
    require('diffview').open(commit_hash .. '~1..' .. commit_hash)
  end
end

M.find_nvim = function()
  require('telescope.builtin').find_files({
    cwd = vim.fn.stdpath('config'),
    prompt_title = '~ neovim ~',
    results_title = 'Neovim Dotfiles',
  })
end

M.find_in_plugins = function()
  require('telescope.builtin').find_files({
    cwd = vim.fn.stdpath('data') .. '/site/pack/packer',
    prompt_title = '~ plugins ~',
    results_title = 'Packer Plugins',
  })
end

M.find_dotfiles = function()
  require('telescope.builtin').git_files({
    file_ignore_patterns = { 'icons/', 'themes/' },
    cwd = os.getenv('HOME') .. '/dotfiles',
    prompt_title = '~ dotfiles ~',
    results_title = 'Dotfiles',
  })
end

M.grep_cur_dir = function()
  M.multi_grep({
    cwd = require('telescope.utils').buffer_dir(),
    prompt_title = "~ grep current file's dir ~",
    results_title = 'Current Dir',
  })
end

M.grep_last_search = function()
  local register = vim.fn.getreg('/'):gsub('\\<', ''):gsub('\\>', '')

  if register and register ~= '' then
    require('telescope.builtin').grep_string({
      path_display = { 'shorten' },
      search = register,
    })
  else
    M.multi_grep()
  end
end

---@class GrepOptions
---@field cwd?                  string          root dir to search from
---@field search?               string          the query to search
---@field grep_open_files?      boolean         restrict search to open files
---@field search_dirs?          table           directory/directories/files to search
---@field use_regex?            boolean         if true, special characters won't be escaped
---@field word_match?           string          exact word matching
---@field additional_args?      function|table  additional arguments to be passed on
---@field disable_coordinates?  boolean         don't show the line and row numbers
---@field only_sort_text?       boolean         only sort the text (not file, line, row)
---@field file_encoding?        string          file encoding for the entry
---@field prompt_title?         string          title of the prompt box
---@field results_title?        string          tile of the results box

---@param options? GrepOptions
M.multi_grep = function(options)
  local buf_cwd = vim.fn.expand('%:h')
  local shortcuts = {
    ['l'] = '*.lua',
    ['v'] = '*.vim',
    ['n'] = '*.{vim,lua}',
    ['k'] = '*.kt',
    ['p'] = '*.proto',
    ['c'] = vim.fs.joinpath(buf_cwd, '**'),
    ['.'] = function()
      local path_parts = buf_cwd:split('/')
      return vim.fs.joinpath(path_parts[1], path_parts[2], '**')
    end,
  }

  ---@type table<string|number, any>
  local opts = vim.tbl_deep_extend('keep', options or {}, {
    cwd = vim.loop.cwd(),
    shortcuts = shortcuts,
    pattern = '%s',
  })

  local custom_grep = require('telescope.finders').new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end

      local prompt_split = vim.split(prompt, '  ')

      local args = { 'rg' }
      if prompt_split[1] then
        table.insert(args, '-e')
        table.insert(args, prompt_split[1])
      end

      -- patterns
      if prompt_split[2] then
        table.insert(args, '-g')

        local pattern
        if type(opts.shortcuts[prompt_split[2]]) == 'string' then
          pattern = opts.shortcuts[prompt_split[2]]
        elseif type(opts.shortcuts[prompt_split[2]]) == 'function' then
          pattern = opts.shortcuts[prompt_split[2]]()
        else
          pattern = prompt_split[2]
        end

        table.insert(args, string.format(opts.pattern, pattern))
      end

      return vim.iter({args, __get_rg_gitignore_glob_args(), {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
      }}):flatten():totable()
    end,
    entry_maker = require('telescope.make_entry').gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  require('telescope.pickers')
      .new(opts, {
        debounce = 100,
        prompt_title = '~ grep ~',
        finder = custom_grep,
        previewer = require('telescope.config').values.grep_previewer(opts),
        sorter = require('telescope.sorters').empty(),
      })
      :find()
end

M.pickers = {
  center_dropdown = {
    theme = 'dropdown',
    previewer = false,
    layout_strategy = 'center',
  },
}

return M
