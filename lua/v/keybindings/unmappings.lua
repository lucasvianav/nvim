local unset_keybindings = require('v.utils.mappings').unset_keybindings

unset_keybindings({
    { 'n', '<CR>' },
    { 'n', '<Space>' },
    { 'n', 'ZZ' },

    { { 'n', 'i' }, '<Up>' },
    { { 'n', 'i' }, '<Down>' },
    { { 'n', 'i' }, '<Right>' },
    { { 'n', 'i' }, '<Left>' },

    { { 'i', 'v' }, '<Esc>' },
})
