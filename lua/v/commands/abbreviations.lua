require('v.utils.abbreviations').set_abbreviations({
    -- commands I always get wrong
    { 'E', 'e' },
    { 'E!', 'e!' },
    { 'e1', 'e!' },
    { 'E1', 'e!' },
    { 'Q', 'q' },
    { 'q1', 'q!' },
    { 'q!!', 'noautocmd q' },
    { 'qa!!', 'noautocmd qa' },

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
    { 'PS', 'PackerSync' },
    { 'PC', 'PackerCompile' },
    { 'PCl', 'PackerClean' },
    { 'PSt', 'PackerStatus' },

    -- LSP
    { 'LA', 'LspStart' },
    { 'LI', 'LspInfo' },
    { 'LO', 'LspStop' },
    { 'LR', 'LspRestart' },

    -- other plugins
    { 'DO', 'DiffviewOpen' },
}, 'c')
