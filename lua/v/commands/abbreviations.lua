require('v.utils.abbreviations').set_abbreviations({
    -- commands I always get wrong
    { 'E', 'e' },
    { 'E!', 'e!' },
    { 'e1', 'e!' },
    { 'E1', 'e!' },
    { 'Q', 'q' },
    { 'q1', 'q!' },

    -- overwriting
    { 'W', 'up' },
    { 'w', 'up' },
    { 'Wq', 'x' },
    { 'wq', 'x' },

    -- other commands
    { 'bufo', 'BufOnly' },
    { 'qb', 'BufClose' },
    { 'wqb', 'BqWrite' },

    -- Packer
    { 'PS ', 'PackerSync' },
    { 'PC ', 'PackerCompile' },
    { 'PCl', 'PackerClean' },
    { 'PSt', 'PackerStatus' },

    -- LSP
    { 'LI', 'LspInfo' },

    -- other plugins
    { 'DO', 'DiffviewOpen' },
}, 'c')
