-- DEPENDENCY: eslint_d
local eslint = {{
    lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
    lintStdin = true,
    lintFormats = {'%f:%l:%c: %m'},
    lintIgnoreExitCode = true,
    formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
    formatStdin = true
}}

local lua_format = {{
    formatCommand = 'lua-format -i --indent-width=2 --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb',
    formatStdin = true
}}

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
    },
    root_dir = function(f)
        return root('tsconfig.json')(f) or root('.eslintrc.js', '.git')(f)
    end,
    settings = {
        rootMarkers = {'.eslintrc.js', '.git/'},
        languages = {
            javascript = eslint,
            typescript = eslint,
            -- lua        = lua_format,
        }
    }
}

return M
