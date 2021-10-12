-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/plugins/init.lua
-- TODO: https://github.com/danielnehrig/nvim/blob/master/lua/packer-config/init.lua
-- TODO: https://github.com/mfussenegger/nvim-dap
-- TODO: https://github.com/puremourning/vimspector

local M = {}

function M.getAll(use)
    local _use = require('functions').wrappers.get_packer_use_wrapper(use, 'general')

    -- packer can manage itself as an optional plugin
    _use({
        'wbthomason/packer.nvim',
        cmd = {
            'PackerClean',
            'PackerCompile',
            'PackerInstall',
            'PackerLoad',
            'PackerProfile',
            'PackerStatus',
            'PackerSync',
            'PackerUpdate',
        },
    })

    _use({ 'lewis6991/impatient.nvim' }) -- improve startup time
    _use({ 'antoinemadec/FixCursorHold.nvim' }) -- fixes CursorHold and CursorHoldl
    _use({ 'nvim-lua/plenary.nvim' }) -- great utility lua functions
    _use({ 'editorconfig/editorconfig-vim' }) -- follow .editorconfig files

    -- TODO: define mappings for other prefixes
    -- TODO: https://github.com/folke/which-key.nvim/issues/90
    _use({ 'folke/which-key.nvim' }) -- displays a popup with keybindings

    _use({ 'max397574/better-escape.nvim', event = 'InsertEnter' }) -- better <Esc> with jk

    _use({ 'lucasvianav/vim-unimpaired', event = 'CursorMoved' }) -- pairs of handy bracket maps
    _use({ 'wellle/targets.vim', event = 'CursorMoved' }) -- provides great new text objects
    _use({ 'andymass/vim-matchup', event = 'CursorHold' }) -- make % smarter

    _use({ 'chrisbra/NrrwRgn', cmd = { 'NR', 'NUD' } }) -- focus narrow code section
    _use({ 'mizlan/iswap.nvim', cmd = { 'ISwap', 'ISwapWith' } }) -- easily swap function arguments

    _use({ 'tpope/vim-repeat', keys = '.', fn = 'repeat#set' }) -- enables . repeat for plugins

    -- auto pairs for {[()]}
    -- ALTERNATIVE: jiangmiao/auto-pairs
    -- ALTERNATIVE: steelsojka/pears.nvim
    _use({
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
    })

    -- use nvim in the browser
    use({
        'glacambre/firenvim',
        run = function()
            vim.fn['firenvim#install'](7)
        end,
    })

    -- session manager
    -- TODO: work on #69 (https://github.com/rmagatti/auto-session/issues/69)
    -- https://github.com/lucasvianav/auto-session
    -- TODO:
    -- https://github.com/JoosepAlviste/dotfiles/blob/b09a4eed7bf4c7862a02aa8b14ffe29896a0bfa5/config/nvim/lua/j/plugins.lua#L33-L37
    _use({
        'rmagatti/auto-session',
        event = 'VimLeavePre',
        cmd = {
            'SaveSession',
            'RestoreSession',
            'DeleteSession',
        },
    })

    -- surrounding manipulatiuon maps
    _use({
        'tpope/vim-surround',
        after = 'vim-repeat',
        keys = { 'cs', 'xs', 'ds', { 'x', 'S' }, { 'v', 'S' } },
    })

    -- word manipulation
    _use({
        'tpope/vim-abolish',
        cmd = { 'Abolish', 'Subvert' },
        keys = 'cr',
        after = 'vim-repeat',
    })

    -- maps for toggling comments
    -- ALTERNATIVE: terrortylor/nvim-comment
    -- TODO: swap for numToStr/Comment.nvim
    -- TODO: https://www.reddit.com/r/neovim/comments/q6lq5o/commentnvim_features_go_brrrrr/hgcxcok/?utm_source=reddit&utm_medium=web2x&context=3
    _use({
        'tpope/vim-commentary',
        cmd = { 'Comment', 'Commentary' },
        keys = { 'gc', { 'v', 'gc' } },
    })

    -- interactive scratchpad for js/ts and python
    -- DEPENDENCY: tsun
    _use({
        'metakirby5/codi.vim',
        disable = true,
        cmd = { 'Codi', 'Codi!', 'Codi!!' },
    })

    -- fixes <c-a>/<c-x> for dates, negative numbers, markdown headers, etc
    -- ALTERNATIVE: tpope/vim-speeddating
    -- increment sequences with visual block
    -- ALTERNATIVE: triglav/vim-visual-increment
    _use({
        'monaqa/dial.nvim',
        keys = {
            '<C-a>',
            '<C-x>',
            { 'v', '<C-a>' },
            { 'v', '<C-x>' },
            { 'v', 'g<C-a>' },
            { 'v', 'g<C-x>' },
        },
        after = 'vim-repeat',
    })

    -- align blocks of code
    _use({
        'junegunn/vim-easy-align',
        cmd = 'EasyAlign',
        keys = '<Leader>a',
    })

    -- better clipboard
    _use({
        'svermeulen/vim-easyclip',
        event = { 'CursorMoved', 'InsertEnter' },
        after = 'vim-repeat',
    })

    -- html super snippets
    _use({
        'mattn/emmet-vim',
        ft = {
            'html',
            'vue',
            'javascript.jsx',
            'typescript.tsx',
        },
    })

    -- TSDoc docstrings generation
    -- ALTERNATIVE: TODO: kkoomen/vim-doge
    _use({
        'heavenshell/vim-jsdoc',
        cmd = { 'JsDoc', 'JsDocFormat' },
        keys = '<Leader>j',
        run = 'make install',
    })

    -- multiple cursors
    _use({
        'mg979/vim-visual-multi',
        as = 'multi',
        keys = { '<C-n>', 'gl', { 'x', '<C-n>' } },
    })

    -- zen mode + focusing windows
    _use({
        'Pocco81/TrueZen.nvim',
        cmd = { 'TZFocus', 'TZAtaraxis' },
        keys = { '<F12>', '<C-w>z' },
    })

    -- switch between single-line and multiline statement
    -- TODO: lua version?
    _use({
        'AndrewRadev/splitjoin.vim',
        keys = { 'gS', 'gJ' },
        -- after = 'vim-easyclip',
    })

    -- 2-char search motion
    -- ALTERNATIVE: justinmk/vim-sneak
    -- ALTERNATIVE: easymotion/vim-easymotion
    _use({
        'ggandor/lightspeed.nvim',
        keys = { '<C-s>', '<C-S-s>' },
    })

    -- pulse cursorline after search (makes it easier to find the cursor)
    _use({
        'inside/vim-search-pulse',
        keys = { '/', '?', 'n', 'N', '*', '#' },
    })

    -- custom "indent block" text object
    _use({
        'kana/vim-textobj-indent',
        requires = { 'kana/vim-textobj-user' },
        event = 'CursorMoved',
    })

    -- awesme ascii box drawer
    _use({
        'gyim/vim-boxdraw',
        disable = true,
        keys = {
            { 'v', '+o' },
            { 'v', '+O' },
            { 'v', '+c' },
            { 'v', '+-' },
            { 'v', '+_' },
            { 'v', '+>' },
            { 'v', '+<' },
            { 'v', '++>' },
            { 'v', '++<' },
            { 'v', '+|' },
            { 'v', '+^' },
            { 'v', '+v' },
            { 'v', '+V' },
            { 'v', '++^' },
            { 'v', '++v' },
            { 'v', '++V' },
            { 'v', '+io' },
            { 'v', '+ao' },
        },
    })

    -- markdown previewer in browser
    -- DEPENDENCY: npm
    _use({
        'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        run = 'cd app && npm install',
    })

    -- project search and replace
    -- DEPENDANCY: RG, sed
    _use({
        'windwp/nvim-spectre',
        after = 'plenary.nvim',
        keys = {
            '<Leader>S',
            { 'v', '<Leader>S' },
        },
    })
end

return M
