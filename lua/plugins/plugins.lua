local M = {}

local config = require('plugins.config')

function M.getAll(use)
    use({ 'wbthomason/packer.nvim', event = 'VimEnter' })                    -- packer can manage itself
    use({ 'tjdevries/astronauta.nvim' })                                     -- better mappings in lua
    use({ 'jdhao/better-escape.vim', event = 'InsertEnter' })                -- better <Esc> with jk
    use({ 'andymass/vim-matchup', event = 'CursorMoved' })                   -- make % smarter
    use({ 'kyazdani42/nvim-web-devicons', config = config.devicons })        -- colored icons
    use({ 'tpope/vim-fugitive', cmd = { 'Git' }, config = config.fugitive }) -- git CLI for command mode

    -- fancy statusline
    use({
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons'},
        after = 'nvim-web-devicons',
        -- config = config.galaxyline,
    })

    -- fancy bufferline
    use({
        'akinsho/nvim-bufferline.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        after = 'nvim-web-devicons',
        config = config.bufferline,
    })

    -- highlight color codes
    use({
        'norcalli/nvim-colorizer.lua',
        event = 'BufRead',
        config = config.colorizer,
    })

    -- treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead', run = ':TSUpdate',
        config = config.colorizer,
    })

    -- git decorations
    use({
        'lewis6991/gitsigns.nvim',
        after = 'plenary.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = config.gitsigns,
    })

    -- auto pairs for ( [ {
    use({
        -- 'jiangmiao/auto-pairs',
        'windwp/nvim-autopairs',
        after = 'nvim-treesitter',
        config = config.autopairs,
    })

    -- maps for toggling comments
    use({
        'tpope/vim-commentary',
        'terrortylor/nvim-comment',
        cmd = 'CommentToggle',
        config = config.comment,
    })

    -- indentation rulers
    use({
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        config = config.indentBlankline,
    })

end

return M
