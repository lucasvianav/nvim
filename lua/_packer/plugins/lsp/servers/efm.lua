--[[ DEPENDENCIES:
    @PACKAGE_MANAGERS:
        npm
        pip
        cargo

    @SOFTWARES:
        markdownlint-cli (npm)
        eslint_d         (npm)
        prettier         (npm)
        fsouza/prettierd (npm)
        black            (pip)
        isort            (pip)
        mypy             (pip)
        flake8           (pip)
        vim-vint         (pip)
        stylua           (cargo)

    @OTHERS:
        cmake
]]

-- linting and simple formatting for js/ts
local eslint_d = {
    lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
    lintStdin = true,
    -- lintFormats = { '%f:%l:%c: %m' },
    -- lintFormats = {'%f:%l:%c:%t: %m'},
    lintFormats = {
        '%f(%l,%c): %tarning %m',
        '%f(%l,%c): %rror %m',
    },
    lintIgnoreExitCode = true,
    formatCommand = 'eslint_d -f visualstudio --fix-to-stdout --stdin --stdin-filename=${INPUT}',
    formatStdin = true,
    lintSource = 'eslint',
}

-- formatting for js/ts/json/yaml/html/css, etc
local prettier = {
    -- PRETTIER:
    --formatCommand = ([[
    --$([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier")
    ----find-config-path
    ----stdin-filepath
    --${INPUT}
    --]]):gsub("\n", " "),

    formatCommand = ([[
    $([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettierd")
    "${INPUT}"
    ]]):gsub('\n', ' '),
    formatStdin = true,

    -- PRETTIERD:
    env = {
        string.format('PRETTIERD_DEFAULT_CONFIG=%s', vim.fn.expand('~/.prettierrc.json')),
    },
}

-- formatting for lua
-- TODO: setup luacheck? https://github.com/mpeterv/luacheck
local stylua = {
    formatCommand = 'stylua -s --stdin-filepath ${INPUT} -',
    formatStdin = true,
    rootMarkers = { '.stylua.toml' },
}

-- formatting for python
local black = {
    formatCommand = 'black --fast -',
    formatStdin = true,
}

-- sorting imports for python
local isort = {
    formatCommand = 'isort --stdout --profile black -',
    formatStdin = true,
}

-- type annotation checker for python
local mypy = {
    lintCommand = 'mypy --show-column-numbers --ignore-missing-imports',
    lintFormats = {
        '%f:%l:%c: %trror: %m',
        '%f:%l:%c: %tarning: %m',
        '%f:%l:%c: %tote: %m',
    },
    lintSource = 'mypy',
    lintStdin = true,
}

-- linter for python
local flake8 = {
    lintCommand = "flake8 --max-line-length 160 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = { '%f:%l:%c: %t%n%n%n %m' },
    lintSource = 'flake8',
}

-- linter for viml
local vint = {
    lintCommand = 'vint -',
    lintStdin = true,
    lintFormats = { '%f:%l:%c: %m' },
    lintSource = 'vint',
}

-- linting for markdown
local markdownlint = {
    lintCommand = 'markdownlint -s',
    lintStdin = true,
    lintFormats = {
        '%f:%l %m',
        '%f:%l:%c %m',
        '%f: %l: %m',
    },
}

--[[ @BASH LINTING/FORMATTING
    local shfmt = {
        formatCommand = "shfmt ${-i:tabWidth}",
    }

    local shellcheck = {
        lintCommand = "shellcheck -f gcc -x -",
        lintStdin = true,
        lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
        lintSource = "shellcheck",
    }
]]

local M = {
    init_options = { documentFormatting = true },
    filetypes = {
        'css',
        'html',
        'javascript',
        'javascript.jsx',
        'javascriptreact',
        'json',
        'lua',
        -- 'markdown',
        'python',
        'scss',
        'typescript',
        'typescript.tsx',
        'typescriptreact',
        'vim',
        'yaml',
    },
    root_dir = vim.loop.cwd,
    settings = {
        rootMarkers = { '.git/' },
        languages = {
            -- TODO: setup estlint --> pretier
            -- https://github.com/JoosepAlviste/dotfiles/blob/b09a4eed7bf4c7862a02aa8b14ffe29896a0bfa5/config/nvim/lua/j/plugins/lsp/efm_ls.lua#L26-L38
            javascript = { eslint_d }, -- prettier?
            javascriptreact = { eslint_d }, -- prettier?
            typescript = { eslint_d }, -- prettier?
            typescriptreact = { eslint_d }, -- prettier?
            -- markdown = { prettier, markdownlint },

            css = { prettier },
            graphql = { prettier },
            html = { prettier },
            json = { prettier },
            scss = { prettier },
            yaml = { prettier },
            vim = { vint },
            lua = { stylua },

            python = {
                black,
                isort,
                flake8,
                mypy,
            },
        },
    },
}

return M
