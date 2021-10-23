local unset_keybindings = require('v.utils.mappings').unset_keybindings

unset_keybindings({
    { 'n', '<CR>'    },
    { 'n', '<Space>' },
    { 'i', '<Up>'    },
    { 'i', '<Down>'  },
    { 'i', '<Right>' },
    { 'i', '<Left>'  },

    { { 'i', 'v' }, '<Esc>' },
})

