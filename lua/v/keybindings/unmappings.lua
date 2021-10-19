local unset_keybindings = require('v.util.mappings').unset_keybindings

unset_keybindings({
    { 'i', '<Esc>'   },
    { 'v', '<Esc>'   },
    { 'n', '<CR>'    },
    { 'n', '<Space>' },
    { 'i', '<Up>'    },
    { 'i', '<Down>'  },
    { 'i', '<Right>' },
    { 'i', '<Left>'  },
})

