local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.general')

    _use({ 'wbthomason/packer.nvim'          })   -- packer can manage itself
    _use({ 'lewis6991/impatient.nvim'        })   -- improve startup time
    _use({ 'jiangmiao/auto-pairs'            })   -- auto pairs for {[()]}
    _use({ 'antoinemadec/FixCursorHold.nvim' })   -- fixes CursorHold and CursorHoldl
    _use({  'nvim-lua/plenary.nvim'          })   -- great utility lua functions

    _use({ 'lucasvianav/vim-unimpaired', event = 'BufRead'     }) -- pairs of handy bracket maps
    _use({ 'jdhao/better-escape.vim',    event = 'InsertEnter' }) -- better <Esc> with jk
    _use({ 'andymass/vim-matchup',       event = 'CursorMoved' }) -- make % smarter
    _use({ 'wellle/targets.vim',         event = 'BufRead'     }) -- provides great new text objects

    _use({ 'chrisbra/NrrwRgn', cmd = { 'NR', 'NUD' } }) -- focus narrow code section
    _use({ 'mizlan/iswap.nvim', cmd = { 'ISwap', 'ISwapWith' } }) -- easily swap function arguments

    _use({ 'wsdjeg/luarefvim', cmd  = 'help', ft = 'lua'        }) -- lua documentation
    _use({ 'tpope/vim-repeat', keys = '.',    fn = 'repeat#set' }) -- enables . repeat for plugins

    -- session manager
    -- TODO: why is this broke????
    _use({
        'rmagatti/auto-session',
        disable = true,
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
        keys = 'cr', after = 'vim-repeat',
    })

    -- maps for toggling comments
    -- ALTERNATIVE: terrortylor/nvim-comment
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
        ft = {
            'html', 'vue',
            'javascript.jsx',
            'typescript.tsx',
        },
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
        event = 'CursorMoved',
    })

    -- awesme ascii box drawer
    _use({
        'gyim/vim-boxdraw',
        disable = true,
        keys = {
            { 'v', '+o' }, { 'v', '+O' }, { 'v', '+c' },
            { 'v', '+-' }, { 'v', '+_' }, { 'v', '+>' },
            { 'v', '+<' }, { 'v', '++>' }, { 'v', '++<' },
            { 'v', '+|' }, { 'v', '+^' }, { 'v', '+v' },
            { 'v', '+V' }, { 'v', '++^' }, { 'v', '++v' },
            { 'v', '++V' }, { 'v', '+io' }, { 'v', '+ao' },
        }
    })

    -- markdown previewer in browser
    -- DEPENDENCY: npm
    _use({
        'iamcco/markdown-preview.nvim', 
        ft='markdown',
        run = 'cd app && npm install'
    })

    -- project search and replace
    -- DEPENDANCY: RG, sed
    _use({
        'windwp/nvim-spectre',
        after = 'plenary.nvim',
        keys = { 
            '<Leader>S', 
            { 'v', '<Leader>S' } 
        }
    })
end

return M


