local actions = require("telescope.actions")
local telescope = require("telescope")
local v = {
  actions = require("v.plugins.navigation.telescope.actions"),
  configs = require("v.plugins.navigation.telescope.configs"),
}

local picker_mappings = {
  ["<C-k>"] = actions.move_selection_previous,
  ["<C-j>"] = actions.move_selection_next,
  ["<C-c>"] = actions.close,

  -- edit in split
  ["<C-v>"] = actions.file_vsplit,
  ["<C-h>"] = actions.file_split,
  ["<C-s>"] = actions.file_split,

  -- copy file path/name
  ["<C-f>"] = v.actions.copy_path_abs + actions.close,
  ["<C-p>"] = v.actions.copy_path_rel + actions.close,
  ["<C-n>"] = v.actions.copy_file_name + actions.close,

  -- selecion
  ["<C-a>"] = actions.select_all,
  ["<C-y>"] = actions.toggle_selection,
  ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
  ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,

  -- send to quickfix
  ["<M-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
  ["<M-C-Q>"] = actions.smart_send_to_qflist + actions.open_qflist,
}

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "   ",
    initial_mode = "insert",
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    path_display = { "truncate" },
    file_ignore_patterns = {
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.otf",
      "%.ttf",
      "%.eot",
      "%.svg",
      "%.woff2",
    },
    mappings = {
      i = picker_mappings,
      n = vim.tbl_extend("force", picker_mappings, {
        ["q"] = actions.close,
        ["v"] = actions.file_vsplit,
        ["s"] = actions.file_split,
      }),
    },
  },
  pickers = {
    git_commits = {
      previewer = false,
      theme = "dropdown",
      mappings = {
        i = {
          ["<CR>"] = v.actions.open_in_diff,
          ["<c-o>"] = v.actions.open_in_diff,
        },
        n = {
          ["<CR>"] = v.actions.open_in_diff,
        },
      },
    },
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
      show_all_buffers = true,
      previewer = false,
      theme = "dropdown",

      mappings = {
        i = {
          ["<M-C-S-H>"] = actions.delete_buffer,
        },

        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },

    git_branches = v.configs.center_dropdown,
    diagnostics = v.configs.center_dropdown,
  },
  extensions = {
    wrap_results = true,
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
})

local ok = pcall(telescope.load_extension, "fzf")

if not ok then
  vim.notify("Failed to load FZF extension.", vim.log.levels.ERROR, {
    title = "Telescope",
  })
end

local builtin = require("telescope.builtin")
v.pickers = require("v.plugins.navigation.telescope.pickers")
v.searchers = require("v.plugins.navigation.telescope.searchers")

require("v.utils.mappings").set_keybindings({
  -- search files and text
  { "n", "<Leader>ff", v.pickers.find_files_fd, desc = "Find Files" },
  { "n", "<Leader>fpp", v.pickers.multi_grep, desc = "Grep" },

  -- utilities
  { "n", "<Leader>fr", builtin.resume, desc = "Resume Last Search" },
  { "n", "<Leader>fb", builtin.buffers, desc = "Find Buffers" },
  { "n", "<Leader>fco", builtin.commands, desc = "Find Commands" },
  { "n", "<Leader>fch", builtin.command_history, desc = "Find Command History" },
  { "n", "<Leader>fj", builtin.jumplist, desc = "Find Jumplist" },
  { "n", "<Leader>fh", builtin.help_tags, desc = "Find Help" },
  { "n", "z=", builtin.spell_suggest, desc = "Spelling Suggestions" },

  -- git
  { "n", "<Leader>gb", builtin.git_branches, desc = "Git Branches" },
  { "n", "<Leader>gc", builtin.git_commits, desc = "Git Commits" },
  { "n", "<Leader>gs", builtin.git_status, desc = "Git Status" },

  -- extensions
  {
    "n",
    "<Leader>fs",
    [[<cmd>lua require('telescope').extensions['session-lens'].search_session()<cr>]],
    desc = "Neovim Sessions",
  },

  -- custom functions
  { "n", "<leader>fn", v.searchers.find_nvim, desc = "Find Neovim Dotfiles" },
  { "n", "<leader>fk", v.searchers.find_in_plugins, desc = "Find Plugins" },
  { "n", "<leader>fpk", v.searchers.grep_in_plugins, desc = "Grep Plugins" },
  { "n", "<leader>fd", v.searchers.find_dotfiles, desc = "Find Dotfiles" },
  { "n", "<leader>f/", v.searchers.grep_last_search, desc = "Grep Last /" },

  groups = {
    { "<leader>f", "Find" },
    { "<leader>g", "Git (Find)" },
  },
})
