require('v.utils').set_viml_options('EasyClip', {
  AutoFormat = true,
  UseSubstituteDefaults = false,
  UseCutDefaults = false,
  EnableBlackHoleRedirect = true,
  UseYankDefaults = true,
  UsePasteDefaults = true,
  UsePasteToggleDefaults = false,
  UseGlobalPasteToggle = false,
})

require('v.utils.mappings').set_keybindings({
  -- use s for substituting
  { 'n', 's',          '<Plug>SubstituteOverMotionMap' },
  { 'n', 'ss',         '<Plug>SubstituteLine' },
  { 'x', 's',          '<Plug>XEasyClipPaste' },
  { 'n', 'S',          '<Plug>SubstituteToEndOfLine' },

  -- use x for cutting
  { 'n', 'x',          '<Plug>MoveMotionPlug' },
  { 'x', 'x',          '<Plug>MoveMotionXPlug' },
  { 'n', 'xx',         '<Plug>MoveMotionLinePlug' },
  { 'n', 'X',          '<Plug>MoveMotionEndOfLinePlug' },

  -- toggle paste autoformat
  { 'n', '<leader>cf', '<Plug>EasyClipToggleFormattedPaste' },

  -- paste in insert mode
  { 'i', '<m-v>',      '<c-v>' },
  { 'i', '<c-v>',      '<Plug>EasyClipInsertModePaste' },

  -- navigate through the yank ring
  { 'n', '[p',         '<Plug>EasyClipRotateYanksForward' },
  { 'n', ']p',         '<Plug>EasyClipRotateYanksBackward' },
  { 'x', ']p',         '<Plug>EasyClipRotateYanksForward' },
  { 'x', '[p',         '<Plug>EasyClipRotateYanksBackward' },

  -- restore mark mapping
  { 'n', 'm',          'm' },
  { 'n', 'mm',         'mm' },
})
