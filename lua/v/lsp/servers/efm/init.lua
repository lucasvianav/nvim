--[[ DEPENDENCIES:
    @PACKAGE_MANAGERS:
        npm
        pip
        cargo

    @SOFTWARES:
        eslint_d         (npm)
        fsouza/prettierd (npm)
        markdownlint-cli (npm)
        prettier         (npm)
        sqlint           (npm)
        black            (pip)
        flake8           (pip)
        isort            (pip)
        mypy             (pip)
        vim-vint         (pip)
        stylua           (cargo)

    @OTHERS:
        cmake
]]

-- TODO: https://github.com/creativenull/efmls-configs-nvim

local M = {}

v.plug.load("efmls-configs-nvim")

local if_enabled = require("v.lsp.servers.efm.utils").if_enabled

-- linting and simple formatting for js/ts
local eslint_d = {
  lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {
    "%f(%l,%c): %tarning %m",
    "%f(%l,%c): %rror %m",
  },
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d -f visualstudio --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true,
  lintSource = "eslint_d",
  rootMarkers = {
    ".eslintrc.cjs",
    ".eslintrc.js",
    ".eslintrc.ts",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "package.json",
  },
}

-- formatting for js/ts/json/yaml/html/css, etc
local prettier = if_enabled("prettier", {
  formatCommand = ([[
    $([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier")
    --find-config-path
    --stdin-filepath
    ${INPUT}
    ]]):gsub("\n", " "),

  formatStdin = true,
  rootMarkers = {
    ".prettierrc",
    ".prettierrc.json",
    "package.json",
  },
})

-- formatting for js/ts/json/yaml/html/css, etc
local prettierd = if_enabled("prettier", {
  formatCommand = ([[
        $([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettierd")
        "${INPUT}"
    ]]):gsub("\n", " "),

  formatStdin = true,
  rootMarkers = {
    ".prettierrc",
    ".prettierrc.json",
    "package.json",
  },

  env = {
    string.format("PRETTIERD_DEFAULT_CONFIG=%s", vim.fn.expand("~/.prettierrc.json")),
  },
})

-- formatting for lua
-- TODO: setup luacheck? https://github.com/mpeterv/luacheck
-- https://github.com/rockerBOO/dotfiles/blob/current/config/efm-langserver/config.yaml#L3-L4
-- TODO: setup CI w/ github actions (+ unit tests --> lua busted)
local stylua = {
  formatCommand = "stylua -s --stdin-filepath ${INPUT} -",
  formatStdin = true,
  rootMarkers = {
    ".stylua.toml",
  },
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
  lintCommand = "mypy --show-column-numbers",
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
  lintCommand = "flake8 --max-line-length 80 --ignore E203,F841 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintFormats = { "%f:%l:%c: %t%n%n%n %m" },
  lintSource = "flake8",
}

-- linting for markdown
local markdownlint = {
  lintCommand = "markdownlint -s",
  lintStdin = true,
  lintFormats = {
    "%f:%l %m",
    "%f:%l:%c %m",
    "%f: %l: %m",
  },
}

-- linting for sql
local sqlint = {
  lintCommand = "sqlint -f stylish --stdin",
  lintStdin = true,
  lintFormats = {
    "%f(%l:%c) %tarning %m",
    "%f(%l:%c) %rror %m",
  },
  lintIgnoreExitCode = true,
  formatCommand = "sqlint -f stylish --stdin --fix",
  formatStdin = true,
  lintSource = "sqlint",
  rootMarkers = {
    ".sqlintrc.json",
    "package.json",
  },
}

-- linting for haskell
local hlint = {
  lintStdin = true,
  lintCommand = "hlint -j -f",
  formatStdin = true,
  formatCommand = "hlint --refactor -j -f",
  rootMarkers = {
    "hie.yaml",
    "stack.yaml",
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

local ktlint = if_enabled(require("v.lsp.servers.efm.ktlint").config)
local vint = if_enabled("vint", ({ pcall(require, "efmls-configs.linters.vint") })[2])
local biome = if_enabled("biome", ({ pcall(require, "efmls-configs.formatters.biome") })[2])
local systemdlint = if_enabled(require("v.lsp.servers.efm.systemdlint").config)

local languages = {
  javascript = { eslint_d, prettierd, biome },
  typescript = { eslint_d, prettierd, biome },
  javascriptreact = { eslint_d, prettierd, biome },
  typescriptreact = { eslint_d, prettierd, biome },

  markdown = { prettier },
  css = { prettierd },
  graphql = { prettierd },
  html = { prettierd },
  json = { prettierd, biome },
  scss = { prettierd },
  yaml = { prettierd },

  vim = { vint },
  lua = { stylua },
  sql = { sqlint },
  haskell = { hlint },
  kotlin = { ktlint },

  python = {
    black,
    isort,
    -- flake8,
    -- mypy,
  },
}

M.config = {
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
    codeAction = false,
    completion = false,
    documentSymbol = false,
    hover = false,
  },
  filetypes = vim.tbl_keys(languages),
  root_dir = vim.uv.cwd(),
  settings = {
    rootMarkers = table.merge_lists({
      ".eslintrc.cjs",
      ".eslintrc.js",
      ".eslintrc.json",
      ".eslintrc.ts",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".prettierrc",
      ".prettierrc.json",
      ".sqlintrc.json",
      ".stylua.toml",
      "package.json",
      "requirements.txt",
      "hie.yaml",
      "stack.yaml",
      ktlint.rootMarkers,
      vint.rootMarkers,
      biome.rootMarkers,
    }),
    lintDebounce = 200,
    lint_debounce = 200,
    debounce = 200,
    logLevel = 10,
    logFile = "/tmp/efm.log",
    languages = languages,
  },
}

function M.on_attach(client)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
  client.server_capabilities.hoverProvider = false
  client.server_capabilities.renameProvider = false
end

return M
