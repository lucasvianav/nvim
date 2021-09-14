local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.general')

    _use({ 'wbthomason/packer.nvim' }) -- packer can manage itself
    _use({ 'rmagatti/auto-session'  }) -- session manager
    _use({ 'jiangmiao/auto-pairs'   }) -- auto pairs for {[()]}

    -- _use({ 'jiangmiao/auto-pairs',       event = 'InsertEnter' }) -- auto pairs for {[()]}
    _use({ 'lucasvianav/vim-unimpaired', event = 'BufRead'     }) -- pairs of handy bracket maps
    _use({ 'jdhao/better-escape.vim',    event = 'InsertEnter' }) -- better <Esc> with jk
    _use({ 'andymass/vim-matchup',       event = 'CursorMoved' }) -- make % smarter
    _use({ 'wellle/targets.vim',         event = 'BufRead'     }) -- provides great new text objects

    _use({ 'mizlan/iswap.nvim', cmd = { 'ISwap', 'ISwapWith' } }) -- easily swap function arguments

    _use({ 'wsdjeg/luarefvim', cmd  = 'help', ft = 'lua'        }) -- lua documentation
    _use({ 'tpope/vim-repeat', keys = '.',    fn = 'repeat#set' }) -- enables . repeat for plugins


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
        keys = 'cr', after = 'vim-repeat',
    })

    -- maps for toggling comments
    -- ALTERNATIVE: terrortylor/nvim-comment
    _use({
        'tpope/vim-commentary',
        cmd = 'CommentToggle',
        keys = 'gc',
    })


    -- interactive scratchpad for js/ts and python
    -- DEPENDENCY: tsun
    _use({
        'metakirby5/codi.vim',
        cmd = { 'Codi', 'Codi!', 'Codi!!' },
    })

    -- fixes <c-a>/<c-x> for dates, negative numbers, markdown headers, etc
    -- ALTERNATIVE: tpope/vim-speeddating
    -- increment sequences with visual block
    -- ALTERNATIVE: triglav/vim-visual-increment
    _use({
        'monaqa/dial.nvim',
        keys = {
            '<C-a>', '<C-x>',
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
        event = 'BufRead',
        after = 'vim-repeat',
    })

    -- html super snippets
    _use({
        'mattn/emmet-vim',
        -- event = 'InsertEnter *.html,*.tsx,*.jsx',
        keys = { '<C-/>,' },
    })

    -- TSDoc docstrings generation
    _use({
        'heavenshell/vim-jsdoc',
        cmd = { 'JsDoc', 'JsDocFormat' },
        keys = '<Leader>j',
        run = 'make install',
    })

    -- multiple cursors
    _use({
        'mg979/vim-visual-multi', as = 'multi',
        keys = { '<C-n>', 'gl', { 'x', '<C-n>' } },
    })

    -- zen mode + focusing windows 
    _use({
        'Pocco81/TrueZen.nvim',
        cmd = { 'TZFocus', 'TZAtaraxis' },
        keys = { '<F10>' },
    })

    -- switch between single-line and multiline statement
    _use({
        'AndrewRadev/splitjoin.vim',
        keys = { 'gS', 'gJ' },
        after = 'vim-easyclip',
    })

    -- 2-char search motion
    -- ALTERNATIVE: justinmk/vim-sneak
    -- ALTERNATIVE: easymotion/vim-easymotion
    _use({
        'ggandor/lightspeed.nvim',
        keys = { '<C-s>', '<C-M-s>' },
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
        event = 'BufRead',
    })
end

return M


