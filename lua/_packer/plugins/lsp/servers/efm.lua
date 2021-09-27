--[[ DEPENDENCIES:
    @PACKAGE_MANAGERS:
        npm
        pip
        luarocks (packer deals with this)

    @SOFTWARES:
        eslint_d     (npm)
        prettier     (npm)
        black        (pip)
        isort        (pip)
        mypy         (pip)
        flake8       (pip)
        vim-vint     (pip)
        luaformatter (luarocks) (packer deals with this)

    @OTHERS:
        cmake
]]--

-- linting and simple formatting for js/ts
local eslint_d = {
    lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
    lintStdin = true,
    lintFormats = {'%f:%l:%c: %m'},
    lintIgnoreExitCode = true,
    formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
    formatStdin = true,
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
}

-- formatting for lua
local lua_format = {
    formatCommand = 'lua-format -i',
    formatStdin = true,
}

-- formatting for python
local black = {
    formatCommand = "black --fast -",
    formatStdin = true,
}

-- sorting imports for python
local isort = {
    formatCommand = "isort --stdout --profile black -",
    formatStdin = true,
}

-- type annotation checker for python
local mypy = {
    lintCommand = "mypy --show-column-numbers --ignore-missing-imports",
    lintFormats = {
        "%f:%l:%c: %trror: %m",
        "%f:%l:%c: %tarning: %m",
        "%f:%l:%c: %tote: %m",
    },
    lintSource = "mypy",
    lintStdin = true,
}

-- linter for python
local flake8 = {
    lintCommand = "flake8 --max-line-length 160 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = { "%f:%l:%c: %t%n%n%n %m" },
    lintSource = "flake8",
}

-- linter for viml
local vint = {
    lintCommand = "vint -",
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
    lintSource = "vint",
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
]]--





local root = require('lspconfig').util.root_pattern

local M = {
    init_options = { documentFormatting = true },
    filetypes = {
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
        'javascript.jsx',
        'typescript.tsx',
        'lua',
        'python',
        'vim',
        'markdown',
        'yaml',
        'html',
        'json',
        'css',
        'scss',
    },
    root_dir = vim.loop.cwd,
    settings = {
        rootMarkers = { '.git/' },
        languages = {
            javascript      = { eslint_d },
            javascriptreact = { eslint_d },
            typescript      = { eslint_d },
            typescriptreact = { eslint_d },

            css      = { prettier   },
            graphql  = { prettier   },
            html     = { prettier   },
            json     = { prettier   },
            markdown = { prettier   },
            scss     = { prettier   },
            yaml     = { prettier   },
            vim      = { vint       },
            lua      = { lua_format },

            python = {
                black,
                isort,
                flake8,
                mypy,
            },
        }
    }
}

return M

