local M = {}

M.config = {
  settings = {
    texlab = {
      auxDirectory = ".",
      bibtexFormatter = "texlab",
      build = {
        args = {
          "-X",
          "compile",
          "%f",
          "--synctex",
          "--keep-logs",
          "--keep-intermediates",
        },
        executable = "tectonic",
        forwardSearchAfter = false,
        onSave = false,
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = false,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        args = {},
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false,
      },
    },
  },
}

return M
