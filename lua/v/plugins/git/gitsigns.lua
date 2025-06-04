local gitsigns = require("gitsigns")
local utils = require("v.utils.mappings")

gitsigns.setup({
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 200,
    ignore_whitespace = true,
    use_focus = true,
  },
  preview_config = {
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  auto_attach = true,
  attach_to_untracked = true,
  on_attach = function(bufnr)
    utils.set_keybindings({
      { "n", "<leader>hs", gitsigns.stage_hunk, desc = "Stage Hunk" },
      { "n", "<leader>hr", gitsigns.reset_hunk, desc = "Reset Hunk" },
      {
        "v",
        "<leader>hs",
        function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        desc = "Stage Hunk",
      },
      {
        "v",
        "<leader>hr",
        function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        desc = "Reset Hunk",
      },

      { "n", "<leader>hp", gitsigns.preview_hunk, desc = "Preview Hunk" },
      { "n", "<leader>hi", gitsigns.blame_line, desc = "Blame Line" },
      {
        "n",
        "<leader>hI",
        function()
          gitsigns.blame_line({ full = true })
        end,
        desc = "Blame Line (full)",
      },
      { "n", "<leader>hU", gitsigns.reset_buffer_index, desc = "Unstage all buf hunks" },
      { "n", "yob", gitsigns.toggle_current_line_blame, desc = "Toggle Blame Line" },

      {
        "n",
        "]c",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end,
        desc = "Next Hunk",
      },
      {
        "n",
        "[c",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end,
        desc = "Prev Hunk",
      },
      { { "o", "x" }, "ih", gitsigns.select_hunk },

      group = { "<leader>h", "Git Actions" },
    }, {
      buffer = bufnr,
    })
  end,
})
