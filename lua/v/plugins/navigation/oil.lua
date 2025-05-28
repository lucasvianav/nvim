--TODO: https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#hide-gitignored-files-and-show-git-tracked-hidden-files

local oil = require("oil")

local soft_hidden_files = {}

local hard_hidden_files = {
  "^%.git$",
  "^node_modules$",
  "^%.cache$",
  "^__pycache__$",
  "^%.DS_Store$",
  "^package-lock%.json$",
}

oil.setup({
  default_file_explorer = true,
  columns = {
    { "icon", add_padding = true },
    { "mtime", format = "[%b %d %H:%M]" },
    "size",
  },
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  delete_to_trash = false,
  -- (:help prompt_save_on_select_new_entry)
  prompt_save_on_select_new_entry = false,
  cleanup_delay_ms = 2000,
  lsp_file_methods = {
    enabled = true,
    timeout_ms = 1000,
    autosave_changes = false,
  },
  constrain_cursor = "editable",
  watch_for_changes = false,
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<cr>"] = "actions.select",
    ["<c-v>"] = { "actions.select", opts = { vertical = true } },
    ["<c-s-v>"] = { "actions.select", opts = { vertical = true } },
    ["<c-s-h>"] = { "actions.select", opts = { horizontal = true } },
    ["<c-t>"] = { "actions.select", opts = { tab = true } },
    ["<c-s-t>"] = { "actions.select", opts = { tab = true } },
    ["<c-p>"] = "actions.preview",
    ["<c-c>"] = { "actions.close", mode = "n" },
    ["q"] = { "actions.close", mode = "n" },
    ["<m-r>"] = "actions.refresh",
    ["<c-s-r>"] = "actions.refresh",
    ["grr"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    [".."] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
  },
  use_default_keymaps = false,
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, bufnr)
      if name:match("^%.") ~= nil then
        return true
      end

      for _, it in ipairs(soft_hidden_files) do
        if name:match(it) then
          return true
        end
      end

      local dir = vim.api.nvim_buf_get_name(bufnr):gsub("^oil://", "")
      local abspath = vim.fs.abspath(vim.fs.joinpath(dir, name))
      local is_ignored = vim
        .system({
          "git",
          "check-ignore",
          abspath,
        }, { timeout = 100 })
        :wait().code == 0

      return is_ignored
    end,
    is_always_hidden = function(
      name,
      _ --[[bufnr]]
    )
      for _, it in ipairs(hard_hidden_files) do
        if name:match(it) then
          return true
        end
      end

      return false
    end,
    natural_order = "fast",
    case_insensitive = false,
    sort = {
      { "type", "asc" },
      { "name", "asc" },
    },
    highlight_filename = function(
      _ --[[entry]],
      _ --[[is_hidden]],
      _ --[[is_link_target]],
      _ --[[is_link_orphan]]
    )
      return nil
    end,
  },
  extra_scp_args = {},
  git = {
    add = function(
      _ --[[path]]
    )
      return false
    end,
    mv = function(
      _ --[[src_path]],
      _ --[[dest_path]]
    )
      return false
    end,
    rm = function(
      _ --[[path]]
    )
      return false
    end,
  },
  float = {
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    get_win_title = nil,
    preview_split = "auto",
    override = function(conf)
      return conf
    end,
  },
  preview_win = {
    update_on_cursor_moved = true,
    preview_method = "fast_scratch",
    disable_preview = function(
      _ --[[filename]]
    )
      return false
    end,
    win_options = {},
  },
  confirmation = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = 0.9,
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
  ssh = {
    border = "rounded",
  },
  keymaps_help = {
    border = "rounded",
  },
})

require("v.utils.mappings").map({ "n", "-", oil.open, desc = "Open parent directory" })

-- trigger LSP rename using Snacks
vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    if event.data.actions.type == "move" then
      local snacks_ok, snacks = pcall(require, "snacks")

      if not snacks_ok then
        return
      end

      snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
    end
  end,
})
