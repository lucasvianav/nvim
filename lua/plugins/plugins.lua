function _plugConfig(plugin) return require('plugins.plugins-config.' .. plugin) end

local M = {}

-- Plug 'valloric/MatchTagAlways'                          " highlight enclosing html tag
-- Plug 'AndrewRadev/tagalong.vim'                         " autoedit enclosing html tag
-- Plug 'RRethy/vim-illuminate'                            " highlight other occurrences from under the cursor
-- Plug 'airblade/vim-rooter'                              " updates working directory to the project opened
-- Plug 'alvan/vim-closetag'                               " autoclose html tags
-- Plug 'conornewton/vim-pandoc-markdown-preview'          " live-preview markdown in pdf with pandoc
-- Plug 'editorconfig/editorconfig-vim'                    " follow .editorconfig files
-- Plug 'honza/vim-snippets'                               " snippets!!
-- Plug 'itchyny/vim-gitbranch'                            " provides function to get current git branch
-- Plug 'liuchengxu/vim-which-key'                         " menu for <Leader> maps

function M.getAll(use)
    use({ 'wbthomason/packer.nvim',   event = 'VimEnter'    })  -- packer can manage itself
    use({ 'jdhao/better-escape.vim',  event = 'InsertEnter' })  -- better <Esc> with jk
    use({ 'andymass/vim-matchup',     event = 'CursorMoved' })  -- make % smarter
    use({ 'jiangmiao/auto-pairs',     event = 'InsertEnter' })  -- auto pairs for ( [ {
    use({ 'p00f/nvim-ts-rainbow',     event = 'BufRead'     })  -- color matching surroundings
    use({ 'wellle/targets.vim',       event = 'BufRead'     })  -- provides great new text objects
    use({ 'tpope/vim-repeat', keys = '.', fn = 'repeat#set' })  -- enables . repeat for plugins

    -- git CLI for command mode
    use({
        'tpope/vim-fugitive',
        cmd = { 'Git' },
        config = function() _plugConfig('fugitive') end,
    }) 

    -- ranger file explorer
    use({
        'kevinhwang91/rnvimr',
        cmd = 'RnvimrToggle',
        keys = '<Leader>r',
        config = function() _plugConfig('ranger') end,
    }) 

    -- align blocks of code
    use({
        'junegunn/vim-easy-align',
        cmd = 'EasyAlign',
        keys = '<Leader>a',
        config = function() _plugConfig('easy-align') end,
    })

    -- NERDTree-like file explorer
    use ({
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        after = 'nvim-web-devicons',
        cmd = 'NvimTreeToggle',
        keys = '<Leader>e',
        config = function() _plugConfig('nvim-tree') end
    })

     -- fancy statusline
     use({
         'glepnir/galaxyline.nvim',
         branch = 'main',
         requires = {'kyazdani42/nvim-web-devicons'},
         after = 'nvim-web-devicons',
         -- config = function() _plugConfig('galaxyline') end
     })

     -- fancy bufferline
     use({
         'akinsho/nvim-bufferline.lua',
         requires = 'kyazdani42/nvim-web-devicons',
         after = 'nvim-web-devicons',
         config = function() _plugConfig('bufferline') end
     })

     -- highlight color codes
     use({
         'norcalli/nvim-colorizer.lua',
         event = 'BufRead',
         config = function() _plugConfig('colorizer') end
     })

     -- treesitter
     use({
         'nvim-treesitter/nvim-treesitter',
         event = 'BufRead', run = ':TSUpdate',
         config = function() _plugConfig('treesitter') end
     })

     -- git decorations
     use({
         'lewis6991/gitsigns.nvim',
         requires = { 'nvim-lua/plenary.nvim' },
         event = 'BufRead',
         config = function() _plugConfig('gitsigns') end
     })

    -- maps for toggling comments
    -- @ALTERNATIVE: tpope/vim-commentary
     use({
         'terrortylor/nvim-comment',
         cmd = 'CommentToggle',
         keys = 'gc',
         config = function() _plugConfig('comment') end
     })

     -- indentation rulers
     use({
         'lukas-reineke/indent-blankline.nvim',
         event = 'BufRead',
         config = function() _plugConfig('indent-blankline') end
    })

    -- better clipboard
    use({
        'svermeulen/vim-easyclip',
        event = 'BufRead',
        after = 'vim-repeat',
        config = function() _plugConfig('easyclip') end,
    })

    -- surrounding manipulatiuon maps
    use({
        'tpope/vim-surround',
        after = 'vim-repeat',
        keys = { 'cs', 'xs', 'ds', { 'x', 'S' }, { 'v', 'S' } },
        config = function() _plugConfig('surround') end,
    })

    -- navigate seamlessly between vim widows and tmux panes
    use({
        'numToStr/Navigator.nvim',
        keys = { '<C-h>', '<C-j>', '<C-k>', '<C-l>' },
        config = function() _plugConfig('navigator') end
    })

    -- switch between single-line and multiline statement
    use({
        'AndrewRadev/splitjoin.vim',
        keys = { 'gS', 'gJ' },
        after = 'vim-easyclip',
    })

    -- colored icons
    use({
        'kyazdani42/nvim-web-devicons',
        config = function() _plugConfig('devicons') end,
    }) 

    -- pairs of handy bracket maps
    use({
        'lucasvianav/vim-unimpaired',
        event = 'BufRead',
        config = function() _plugConfig('unimpaired') end,
    }) 

    -- smooth scrolling
    use({
        'karb94/neoscroll.nvim',
        keys = {
            '<C-u>', '<C-d>', '<C-b>', '<C-f>',
            '<C-y>', '<C-e>', 'zt', 'zz', 'zb',
        },
        config = function() _plugConfig('neoscroll') end,
    })

    -- session manager
    use({
        'rmagatti/auto-session',
        config = function() _plugConfig('autosession') end,
    })

    -- zen mode + focusing windows 
    use({
       'Pocco81/TrueZen.nvim',
       cmd = { 'TZFocus', 'TZAtaraxis' },
       keys = { '<F10>' },
       config = function() _plugConfig('truezen') end,
    })

    -- easily swap function arguments
    use({
        'mizlan/iswap.nvim',
        cmd = { 'ISwap', 'ISwapWith' },
        config = function() _plugConfig('iswap') end,
    })

    -- custom "indent block" text object
    use({
        'kana/vim-textobj-indent',
        requires = { 'kana/vim-textobj-user' },
        event = 'BufRead',
    })

    -- pulse cursorline after search (makes it easier to find the cursor)
    use({
        'inside/vim-search-pulse',
        keys = { '/', '?', 'n', 'N', '*', '#' },
    })

    -- work well with LaTeX
    use({
        'lervag/vimtex',
        ft = { 'plaintex', 'tex' },
        config = function() _plugConfig('vimtex') end,
    })

    -- word manipulation
    use({
        'tpope/vim-abolish',
        cmd = { 'Abolish', 'Subvert' },
        keys = 'cr', after = 'vim-repeat',
    })

    -- fixes <c-a>/<c-x> for dates, negative numbers, markdown headers, etc
    -- @ALTERNATIVE: tpope/vim-speeddating
    -- increment sequences with visual block
    -- @ALTERNATIVE: triglav/vim-visual-increment
    use({
        'monaqa/dial.nvim',
        keys = {
            '<C-a>', '<C-x>',
            { 'v', '<C-a>' },
            { 'v', '<C-x>' },
            { 'v', 'g<C-a>' },
            { 'v', 'g<C-x>' },
        }, 
        after = 'vim-repeat',
        config = function() _plugConfig('dial') end,
    })

    -- highlight f/F and t/T targets
    use({
        'unblevable/quick-scope',
        keys = { 'f', 'F', 't', 'T' }, 
        setup = function() _plugConfig('quickscope') end,
    })

    -- TSDoc docstrings generation
    use({
        'heavenshell/vim-jsdoc',
        cmd = { 'JsDoc', 'JsDocFormat' },
        keys = '<Leader>j',
        run = 'make install',
        config = function() _plugConfig('jsdoc') end,
    })

    -- run commands in tmux pane from nvim
    use({
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
        config = function() _plugConfig('vimux') end,
    })

    -- multiple cursors
    use({
        'mg979/vim-visual-multi',
        keys = { '<C-n>', 'gl', { 'x', '<C-n>' } },
        config = function() _plugConfig('multi') end,
    })

    -- html super snippets
    use({
        'mattn/emmet-vim',
        -- event = 'InsertEnter *.html,*.tsx,*.jsx',
        keys = { '<C-/>,' },
        config = function() _plugConfig('emmet') end,
    })

    -- interactive scratchpad for js/ts and python
    -- @DEPENDENCY: tsun
    use({
        'metakirby5/codi.vim',
        cmd = { 'Codi', 'Codi!', 'Codi!!' },
        config = function() _plugConfig('codi') end,
    })

    -- 2-char search motion
    -- @ALTERNATIVE: justinmk/vim-sneak
    -- @ALTERNATIVE: easymotion/vim-easymotion
    use({
        'ggandor/lightspeed.nvim',
        keys = { '<C-s>', '<C-M-s>' },
        config = function() _plugConfig('lightspeed') end,
    })

    -- fuzzy finder
    -- @ALTERNATIVE: junegunn/fzf.vim
    use {
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
        config = function() _plugConfig('telescope') end,
    }

    -- start screen
    -- @ALTERNATIVE: mhinz/vim-startify
    use {
        "glepnir/dashboard-nvim",
        cmd = { "Dashboard", "DashboardNewFile", },
        config = function() _plugConfig('dashboard') end,
    }
end

return M

