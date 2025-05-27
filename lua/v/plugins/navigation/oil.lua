require("oil").setup({
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
  prompt_save_on_select_new_entry = true,
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
    ["<CR>"] = "actions.select",
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    ["<C-s-v>"] = { "actions.select", opts = { vertical = true } },
    ["<C-s-h>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["<C-s-t>"] = { "actions.select", opts = { tab = true } },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["q"] = { "actions.close", mode = "n" },
    ["<m-r>"] = "actions.refresh",
    ["<C-S-R>"] = "actions.refresh",
    ["grr"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
  },
  use_default_keymaps = false,
  view_options = {
    show_hidden = true,
    is_hidden_file = function(
      name,
      _ --[[bufnr]]
    )
      return name:match("^%.") ~= nil
    end,
    is_always_hidden = function(
      _ --[[name]],
      _ --[[bufnr]]
    )
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
