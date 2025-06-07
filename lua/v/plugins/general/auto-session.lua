-- [/**$] will mean any subdirectory recursively (root directory doesn't count)
-- [/*$] will mean any immediate subdirectory (root directory doesn't count)
-- without any of these ^ will mean only root directory
local allowed_dirs = {
  "~/github/**",
  "~/src/**",
  "~/dotfiles",
  "~/dotfiles/nvim/.config/nvim",
}
local suppressed_dirs = {
  "/",
  "/home",
  "~",
  "~/Desktop/**",
  "~/Documents/**",
  "~/Downloads/**",
  "~/Pictures/**",
}

---@param cwd string
---@param dirs string[]
local function is_in(cwd, dirs)
  for _, dir in ipairs(dirs) do
    local possibilities = table.distinct({
      vim.fs.abspath(dir), -- with symlink
      vim.fn.resolve(vim.fs.abspath(dir)), -- symlink resolved
    })

    for _, pat in ipairs(possibilities) do
      if pat:ends_with("/**") then
        local base = pat:gsub("/%*%*$", "")
        if base ~= cwd and cwd:starts_with(base) then
          -- /** allows any level of subdirectories
          return true
        end
      elseif pat:ends_with("/*") then
        local base = pat:gsub("/%*$", "")
        local relpath = vim.fs.relpath(base, cwd)
        if base ~= cwd and relpath and not relpath:contains("/") then
          -- /* allows a single level of subdirectories
          return true
        end
      else
        if pat:gsub("/$", "") == cwd then
          -- no wildcard at the end allows no level
          -- of subdirectories (so only root dir)
          return true
        end
      end
    end
  end

  return false
end

require("auto-session").setup({
  enabled = true,
  auto_save = true,
  auto_restore = false,
  auto_restore_last_session = false,
  auto_delete_empty_sessions = true,
  args_allow_files_auto_save = false,
  args_allow_single_directory = true,
  close_unsupported_windows = true,
  continue_restore_on_error = false,
  log_level = "error",
  -- delete sessions that haven't been used for 15 days
  purge_after_minutes = 60 * 24 * 15,
  -- close unwanted windows before saving
  pre_save_cmds = { "silent! tabdo NvimTreeClose" },
  -- fix Neovim height after start (so cmdheight isn't huge) (#64) (#11330)
  post_restore_cmds = { "silent !kill -s SIGWINCH $PPID" },
  session_lens = {
    load_on_setup = true,
    previewer = false,
  },
  auto_create = function()
    local cwd = (vim.uv or vim.loop).cwd()
    if not cwd then
      return false
    end
    cwd = vim.fn.resolve(vim.fs.abspath(cwd))

    if is_in(cwd, suppressed_dirs) then
      return false
    elseif is_in(cwd, allowed_dirs) then
      return true
    end

    local res = vim
      .system({
        "git",
        "rev-parse",
        "--is-inside-work-tree",
      }, { timeout = 100 })
      :wait()

    return res.code == 0 and res.stdout:trim():to_boolean()
  end,
  bypass_save_filetypes = {
    "",
    "NvimTree",
    "NvimTree_*",
    "dashboard",
    "gitcommit",
    "help",
    "lsp-installer",
    "startify",
    "terminal",
    "text",
    "oil",
    "DiffviewFiles",
  },
})
