local M = {}

-- Plug 'valloric/MatchTagAlways'                          " highlight enclosing html tag
-- Plug 'AndrewRadev/tagalong.vim'                         " autoedit enclosing html tag
-- Plug 'RRethy/vim-illuminate'                            " highlight other occurrences from under the cursor
-- Plug 'airblade/vim-rooter'                              " updates working directory to the project opened
-- Plug 'editorconfig/editorconfig-vim'                    " follow .editorconfig files
-- Plug 'liuchengxu/vim-which-key'                         " menu for <Leader> maps

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins')

    _use({ 'wbthomason/packer.nvim' })   -- packer can manage itself
    _use({ 'rmagatti/auto-session' })    -- session manager

    _use({ 'jdhao/better-escape.vim',      event   = 'InsertEnter' })      -- better <Esc> with jk
    _use({ 'jiangmiao/auto-pairs',         event   = 'InsertEnter' })      -- auto pairs for ( [ {
    _use({ 'andymass/vim-matchup',         event   = 'CursorMoved' })      -- make % smarter
    _use({ 'wellle/targets.vim',           event   = 'CursorMoved' })      -- provides great new text objects
    _use({ 'lucasvianav/vim-unimpaired',   event   = 'CursorMoved' })      -- pairs of handy bracket maps
    _use({ 'p00f/nvim-ts-rainbow',         event   = 'BufNew'      })      -- color matching surroundings
    _use({ 'norcalli/nvim-colorizer.lua',  event   = 'VimEnter'    })      -- highlight color codes
    _use({ 'kyazdani42/nvim-web-devicons', as      = 'devicons'    })      -- colored icons
    _use({ 'xiyaowong/nvim-transparent',   disable = true,         })      -- transparent background

    _use({ 'tpope/vim-fugitive', cmd = { 'Git' } })     -- git CLI for command mode

    _use({ 'lervag/vimtex',     ft  = { 'plaintex', 'tex'       } })    -- work well with LaTeX
    _use({ 'mizlan/iswap.nvim', cmd = { 'ISwap',    'ISwapWith' } })    -- easily swap function arguments

    _use({ 'tpope/vim-repeat', keys = '.',    fn = 'repeat#set' }) -- enables . repeat for plugins
    _use({ 'wsdjeg/luarefvim', cmd  = 'help', ft = 'lua'        }) -- lua documentation

    -- ranger file explorer
    _use({
        'kevinhwang91/rnvimr', as = 'ranger',
        cmd = 'RnvimrToggle', keys = '<Leader>r',
    }) 

    -- align blocks of code
    _use({
        'junegunn/vim-easy-align',
        cmd = 'EasyAlign',
        keys = '<Leader>a',
    })

    -- NERDTree-like file explorer
    _use ({
        'kyazdani42/nvim-tree.lua', as = 'nvim-tree',
        requires = 'kyazdani42/nvim-web-devicons',
        after = 'devicons',
        cmd = 'NvimTreeToggle',
        keys = '<Leader>e',
    })

     -- fancy statusline
     _use({
         'glepnir/galaxyline.nvim',
         branch = 'main',
         requires = {'kyazdani42/nvim-web-devicons'},
         after = 'devicons',
     })
    -- config = function() _plugConfig('galaxyline') end

     -- fancy bufferline
     _use({
         'akinsho/nvim-bufferline.lua',
         requires = 'kyazdani42/nvim-web-devicons',
         after = 'devicons',
     })

     -- treesitter
     _use({
         'nvim-treesitter/nvim-treesitter',
         event = 'BufRead', run = ':TSUpdate',
     })

     -- git decorations
     _use({
         'lewis6991/gitsigns.nvim',
         requires = { 'nvim-lua/plenary.nvim' },
         event = 'BufRead',
     })

    -- maps for toggling comments
    -- @ALTERNATIVE: terrortylor/nvim-comment
     _use({
         'tpope/vim-commentary',
         cmd = 'CommentToggle',
         keys = 'gc',
     })

     -- indentation rulers
     _use({
         'lukas-reineke/indent-blankline.nvim',
         event = 'BufRead',
    })

    -- better clipboard
    _use({
        'svermeulen/vim-easyclip',
        event = 'BufRead',
        after = 'vim-repeat',
    })

    -- surrounding manipulatiuon maps
    _use({
        'tpope/vim-surround',
        after = 'vim-repeat',
        keys = { 'cs', 'xs', 'ds', { 'x', 'S' }, { 'v', 'S' } },
    })

    -- navigate seamlessly between vim widows and tmux panes
    _use({
        'numToStr/Navigator.nvim',
        keys = { '<C-h>', '<C-j>', '<C-k>', '<C-l>' },
    })

    -- switch between single-line and multiline statement
    _use({
        'AndrewRadev/splitjoin.vim',
        keys = { 'gS', 'gJ' },
        after = 'vim-easyclip',
    })

    -- smooth scrolling
    _use({
        'karb94/neoscroll.nvim',
        keys = {
            '<C-u>', '<C-d>', '<C-b>', '<C-f>',
            '<C-y>', '<C-e>', 'zt', 'zz', 'zb',
        },
    })

    -- zen mode + focusing windows 
    _use({
       'Pocco81/TrueZen.nvim',
       cmd = { 'TZFocus', 'TZAtaraxis' },
       keys = { '<F10>' },
    })

    -- custom "indent block" text object
    _use({
        'kana/vim-textobj-indent',
        requires = { 'kana/vim-textobj-user' },
        event = 'BufRead',
    })

    -- pulse cursorline after search (makes it easier to find the cursor)
    _use({
        'inside/vim-search-pulse',
        keys = { '/', '?', 'n', 'N', '*', '#' },
    })

    -- word manipulation
    _use({
        'tpope/vim-abolish',
        cmd = { 'Abolish', 'Subvert' },
        keys = 'cr', after = 'vim-repeat',
    })

    -- fixes <c-a>/<c-x> for dates, negative numbers, markdown headers, etc
    -- @ALTERNATIVE: tpope/vim-speeddating
    -- increment sequences with visual block
    -- @ALTERNATIVE: triglav/vim-visual-increment
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

    -- highlight f/F and t/T targets
    _use({
        'unblevable/quick-scope', as = 'quickscope',
        keys = { 'f', 'F', 't', 'T' }, 
    }, true)
    -- setup = function() _plugConfig('quickscope') end,

    -- TSDoc docstrings generation
    _use({
        'heavenshell/vim-jsdoc',
        cmd = { 'JsDoc', 'JsDocFormat' },
        keys = '<Leader>j',
        run = 'make install',
    })

    -- run commands in tmux pane from nvim
    _use({
        'preservim/vimux',
        cmd = {
            'VimuxPromptCommand', 'VimuxRunLastCommand',
            'VimuxInspectRunner', 'VimuxZoomRunner',
            'VimuxClearScreenHistory', 'VimuxTogglePane',
        },
        keys = {
            '<Leader>tp', '<Leader>tr', '<Leader>ti',
            '<Leader>tz', '<Leader>tc', '<Leader>tt',
        },
    })

    -- multiple cursors
    _use({
        'mg979/vim-visual-multi', as = 'multi',
        keys = { '<C-n>', 'gl', { 'x', '<C-n>' } },
    })

    -- html super snippets
    _use({
        'mattn/emmet-vim',
        -- event = 'InsertEnter *.html,*.tsx,*.jsx',
        keys = { '<C-/>,' },
    })

    -- interactive scratchpad for js/ts and python
    -- @DEPENDENCY: tsun
    _use({
        'metakirby5/codi.vim',
        cmd = { 'Codi', 'Codi!', 'Codi!!' },
    })

    -- 2-char search motion
    -- @ALTERNATIVE: justinmk/vim-sneak
    -- @ALTERNATIVE: easymotion/vim-easymotion
    _use({
        'ggandor/lightspeed.nvim',
        keys = { '<C-s>', '<C-M-s>' },
    })

    -- fuzzy finder
    -- @ALTERNATIVE: junegunn/fzf.vim
    _use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { 'nvim-lua/plenary.nvim' },
            -- {
            --     "nvim-telescope/telescope-media-files.nvim",
            --     disable = not plugin_status.telescope_media,
            --     setup = function()
            --         require("mappings").telescope_media()
            --     end,
            -- },
        },
    })

    -- start screen
    -- @ALTERNATIVE: mhinz/vim-startify
    _use({
        "glepnir/dashboard-nvim",
        cmd = { "Dashboard", "DashboardNewFile", },
    })

    _use({ 'neovim/nvim-lspconfig' })
    _use({
        'kabouzeid/nvim-lspinstall',
        after = 'nvim-lspconfig',
        event = 'BufRead',
        cmd = { 'LspInstall', 'LspUninstall' },
    })
    _use({ 'kosayoda/nvim-lightbulb' })
    -- _use({ 'onsails/lspkind-nvim' })

    -- code completion
    -- @ALTERNATIVE: hrsh7th/nvim-cmp
    -- @DEPENDENCY: python3-venv
    _use({ 'ms-jpq/coq_nvim', branch = 'coq' })
    _use({ 'ms-jpq/coq.artifacts', branch = 'artifacts', after = 'coq_nvim' })
end

return M

