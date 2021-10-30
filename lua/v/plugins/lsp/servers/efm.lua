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
    lintFormats = {
        '%f(%l,%c): %tarning %m',
        '%f(%l,%c): %rror %m',
    },
    lintIgnoreExitCode = true,
    formatCommand = 'eslint_d -f visualstudio --fix-to-stdout --stdin --stdin-filename=${INPUT}',
    formatStdin = true,
    lintSource = 'eslint_d',
    rootMarkers = {
        '.eslintrc.cjs',
        '.eslintrc.js',
        '.eslintrc.ts',
        '.eslintrc.yaml',
        '.eslintrc.yml',
        '.eslintrc.json',
        'package.json',
    },
}

-- formatting for js/ts/json/yaml/html/css, etc
local prettier = {
    formatCommand = ([[
    $([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier")
    --find-config-path
    --stdin-filepath
    ${INPUT}
    ]]):gsub("\n", " "),

    formatStdin = true,
    rootMarkers = {
        '.prettierrc',
        '.prettierrc.json',
        'package.json',
    },
}

-- formatting for js/ts/json/yaml/html/css, etc
local prettierd = {
    formatCommand = ([[
        $([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettierd")
        "${INPUT}"
    ]]):gsub('\n', ' '),

    formatStdin = true,
    rootMarkers = {
        '.prettierrc',
        '.prettierrc.json',
        'package.json',
    },

    env = {
        string.format('PRETTIERD_DEFAULT_CONFIG=%s', vim.fn.expand('~/.prettierrc.json')),
    },
}

-- formatting for lua
-- TODO: setup luacheck? https://github.com/mpeterv/luacheck
-- https://github.com/rockerBOO/dotfiles/blob/current/config/efm-langserver/config.yaml#L3-L4
-- TODO: setup CI w/ github actions (+ unit tests --> lua busted)
local stylua = {
    formatCommand = 'stylua -s --stdin-filepath ${INPUT} -',
    formatStdin = true,
    rootMarkers = {
        '.stylua.toml',
    },
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
    init_options = {
        codeAction = false,
        completion = false,
        documentFormatting = true,
        documentSymbol = false,
        hover = false,
    },
    filetypes = {
        'css',
        'html',
        -- 'javascript',
        'javascript.jsx',
        'javascriptreact',
        'json',
        'lua',
        'python',
        'scss',
        -- 'typescript',
        'typescript.tsx',
        'typescriptreact',
        'vim',
        'yaml',
    },
    root_dir = vim.loop.cwd,
    settings = {
        rootMarkers = {
            -- '.eslintrc.cjs',
            -- '.eslintrc.js',
            -- '.eslintrc.json',
            -- '.eslintrc.ts',
            -- '.eslintrc.yaml',
            -- '.eslintrc.yml',
            '.git/',
            '.prettierrc',
            '.prettierrc.json',
            '.stylua.toml',
            'package.json',
            'requirements.txt',
        },
        lintDebounce = 100,
        logLevel = 10,
        logFile = '/tmp/efm.log',
        languages = {
            -- javascript = { eslint_d },
            -- typescript = { eslint_d },
            javascriptreact = { prettierd },
            typescriptreact = { prettierd },
            -- markdown = { prettier, markdownlint },

            css = { prettierd },
            graphql = { prettierd },
            html = { prettierd },
            json = { prettierd },
            scss = { prettierd },
            yaml = { prettierd },
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
