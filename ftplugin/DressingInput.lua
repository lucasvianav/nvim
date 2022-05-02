require('v.utils.mappings').set_keybindings({
  { 'n', '<C-C>', '<Esc>' },
  { 'n', 'q', '<Esc>' },
  { 'i', '<ESC>', '<C-C>' },
}, {
  buffer = true,
  remap = true,
})
