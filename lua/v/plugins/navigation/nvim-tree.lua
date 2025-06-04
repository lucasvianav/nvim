local api = require("nvim-tree.api")
local on_attach = function(bufnr)
  local desc = function(description)
    return {
      desc = "nvim-tree: " .. description,
    }
  end

  require("v.utils.mappings").set_keybindings({
    { "n", { "v", "<C-v>" }, api.node.open.vertical,          desc("Open: Vertical Split") },
    { "n", { "s", "<C-x>" }, api.node.open.horizontal,        desc("Open: Horizontal Split") },
    { "n", { "t", "<C-t>" }, api.node.open.tab,               desc("Open: New Tab") },
    { "n", { "<CR>", "l" },  api.node.open.edit,              desc("Open") },
    { "n", "h",              api.node.navigate.parent_close,  desc("Close Directory") },
    { "n", "<Tab>",          api.node.open.preview,           desc("Open Preview") },
    { "n", "P",              api.node.navigate.parent,        desc("Parent Directory") },
    { "n", "K",              api.node.navigate.sibling.first, desc("First Sibling") },
    { "n", "J",              api.node.navigate.sibling.last,  desc("Last Sibling") },
    {
      "n",
      "I",
      api.tree.toggle_gitignore_filter,
      desc("Toggle Filter: Git Ignore"),
    },
    { "n", { "H", "zh", "gh" }, api.tree.toggle_hidden_filter, desc("Toggle Filter: Dotfiles") },
    { "n", "R",                 api.tree.reload,               desc("Refresh") },
    {
      "n",
      { "a", "A" },
      api.fs.create,
      desc("Create File Or Directory"),
    },
    { "n", "dd",           api.fs.remove,                  desc("Delete") },
    { "n", "r",            api.fs.rename,                  desc("Rename") },
    { "n", "<C-r>",        api.fs.rename_full,             desc("Rename: Full Path") },
    { "n", "xx",           api.fs.cut,                     desc("Cut") },
    { "n", "yy",           api.fs.copy.node,               desc("Copy") },
    { "n", "p",            api.fs.paste,                   desc("Paste") },
    { "n", "yn",           api.fs.copy.filename,           desc("Copy Name") },
    { "n", { "yp", "Y" },  api.fs.copy.relative_path,      desc("Copy Relative Path") },
    { "n", { "ya", "gy" }, api.fs.copy.absolute_path,      desc("Copy Absolute Path") },
    { "n", "]c",           api.node.navigate.git.prev,     desc("Prev Git") },
    { "n", "[c",           api.node.navigate.git.next,     desc("Next Git") },
    { "n", "<BS>",         api.tree.change_root_to_parent, desc("Up") },
    { "n", "q",            api.tree.close,                 desc("Close") },
    { "n", "?",            api.tree.toggle_help,           desc("Help") },
    { "n", "cd",           api.tree.change_root_to_node,   desc("CD") },
  }, {
    buffer = bufnr,
    noremap = true,
  })
end

require("nvim-tree").setup({
  disable_netrw = false,           -- disables netrw completely
  hijack_netrw = false,            -- hijack netrw window on startup
  open_on_tab = false,             -- opens nvimtree when on a new tab
  hijack_cursor = false,           -- keep cursor at filename's start
  update_cwd = false,              -- update cwd on `DirChanged`
  create_in_closed_folder = false, -- cursor is on a closed dir: create new file on the parent

  -- show diagnostics in the signcol
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },

  -- show focused file on the tree
  update_focused_file = {
    enable = false,
    update_cwd = false, -- update cwd to contain the file if it doesn't
    ignore_list = {},
  },

  view = {
    adaptive_size = true,
    width = "13%",
    side = "left",
  },

  renderer = {
    group_empty = true,          -- compact empty nested directories
    add_trailing = true,         -- trailing `/` to dir names
    highlight_git = true,        -- highlight files with git attributtes
    highlight_opened_files = "all",
    root_folder_modifier = ":t", -- tail cwd

    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "after",
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
      glyphs = {
        default = "",
        git = {
          unstaged = "",
          staged = "",
          unmerged = "",
          renamed = "",
          untracked = "",
          deleted = "",
        },
      },
    },
    special_files = {
      "MAKEFILE",
      "Makefile",
      "README.md",
      ".gitignore",
      "package.json",
    },
  },

  filters = {
    dotfiles = false, -- don't hide .files

    -- dirs/files to be ignored
    custom = {
      "^\\.git$",
      "^node_modules$",
      "^\\.cache$",
      "^__pycache__$",
      "^.DS_Store$",
      "^package-lock\\.json$",
    },
  },
  on_attach = on_attach,
})

-- when opening the tree, expand only current file
require("v.utils.mappings").map({
  "n",
  "<Leader>e",
  function()
    api.tree.toggle({ find_file = true })
  end,
})
api.events.subscribe(api.events.Event.TreeOpen, function()
  api.tree.collapse_all(false)
end)

local colors = require("v.utils").colors
local hl_utils = require("v.utils.highlights")
local alter_color = hl_utils.alter_color

hl_utils.set_highlights({
  {
    "NvimTreeRootFolder",
    {
      bold = true,
      italic = true,
      fg = colors.off_white,
    },
  },
  {
    "NvimTreeGitDirty",
    { fg = alter_color(colors.blue_light, -10) },
  },
  {
    "NvimTreeOpenedFolderName",
    {
      bold = true,
      italic = true,
      fg = alter_color(colors.yellow, -10),
    },
  },
})

-- trigger LSP rename using Snacks
local prev = { new_name = "", old_name = "" } -- Prevent duplicate events
vim.api.nvim_create_autocmd("User", {
  pattern = "NvimTreeSetup",
  callback = function()
    local events = require("nvim-tree.api").events
    events.subscribe(events.Event.NodeRenamed, function(data)
      local snacks_ok, snacks = pcall(require, "snacks")

      if not snacks_ok then
        return
      end

      if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        snacks.rename.on_rename_file(data.old_name, data.new_name)
        prev = data
      end
    end)
  end,
})
