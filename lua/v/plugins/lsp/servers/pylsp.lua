-- TODO: https://github.com/williamboman/nvim-lsp-installer/blob/main/lua/nvim-lsp-installer/servers/pylsp/README.md

local M = {}

-- DEPENCENCIES:
-- pycodestyle
-- pydocstyle
-- jedi
-- mypy
-- pylsp-mypy
-- black
-- python-lsp-black
-- flake8
-- pyls-flake8
-- isort
-- pyls-isort
-- rope
-- pylsp-rope

local enable = { enable = true }
local disable = { enable = false }
local pydocstyle_ignore = {
  "D100",
  "D101",
  "D102",
  "D103",
  "D104",
  "D105",
  "D106",
  "D107",
  "D205",
  "D400",
}
local pycodestyle_ignore = {
  "E203",
}
local flake8_ignore = {
  "E203",
  "F401",
  "F841",
}

M.config = {
  settings = {
    pylsp = {
      plugins = {
        jedi_completion = {
          fuzzy = true,
          include_params = true,
        },
        flake8 = {
          enabled = true,
          hangClosing = false,
          maxLineLength = 160,
          ignore = flake8_ignore,
          addIgnore = flake8_ignore,
        },
        pyls_flake8 = {
          enabled = true,
          hangClosing = false,
          maxLineLength = 160,
          ignore = flake8_ignore,
          addIgnore = flake8_ignore,
        },
        pycodestyle = {
          hangClosing = false,
          maxLineLength = 160,
          ignore = pycodestyle_ignore,
          addIgnore = pycodestyle_ignore,
        },
        pydocstyle = {
          enabled = true,
          convention = "numpy",
          ignore = pydocstyle_ignore,
          addIgnore = pydocstyle_ignore,
        },
        pylint = enable,
        rope = disable,
        pylsp_rope = disable,
        pylsp_mypy = enable,
        pyls_isort = disable,
        autopep8 = disable,
        black = disable,
        python_lsp_black = disable,
        pyls_black = disable,
        pylsp_black = disable,
      },
    },
  },
}

M.on_attach = require("v.utils.lsp.on_attach").disable_formatting

return M
