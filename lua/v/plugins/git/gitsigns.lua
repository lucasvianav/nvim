require('gitsigns').setup({
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = true,
    use_focus = true,
  },
  preview_config = {
    border = 'rounded',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    require('v.utils.mappings').set_keybindings({
      { { 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', desc = 'Stage Hunk' },
      { { 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', desc = 'Reset Hunk' },
      { 'n',          '<leader>hu', gs.undo_stage_hunk,         desc = 'Undo Stage Hunk' },
      { 'n',          '<leader>hp', gs.preview_hunk,            desc = 'Preview Hunk' },
      { 'n',          '<leader>hi', gs.blame_line,              desc = 'Blame Line' },
      {
        'n',
        '<leader>hI',
        function()
          gs.blame_line({ full = true })
        end,
        desc = 'Blame Line (full)',
      },
      { 'n', '<leader>hU', gs.reset_buffer_index,        desc = 'Unstage all buf hunks' },
      { 'n', '<leader>hb', gs.toggle_current_line_blame, desc = 'Toggle Blame Line' },
      {
        'n',
        ']h',
        "&diff ? ']h' : '<cmd>Gitsigns next_hunk<CR>'",
        { expr = true },
        desc = 'Next Hunk',
      },
      {
        'n',
        '[h',
        "&diff ? '[h' : '<cmd>Gitsigns prev_hunk<CR>'",
        { expr = true },
        desc = 'Prev Hunk',
      },
      { { 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>' },

      group = { '<leader>h', 'Git Actions' },
    }, {
      buffer = bufnr,
    })
  end,
})
