require("v.utils.abbreviations").set_abbreviations({
  -- commands I always get wrong
  { "E", "e" },
  { "E!", "e!" },
  { "e1", "e!" },
  { "E1", "e!" },
  { "Q", "q" },
  { "q1", "q!" },

  -- overwriting
  { "W", "up" },
  { "w", "up" },
  { "Wq", "x" },
  { "wq", "x" },

  -- no autocommands
  { "q!!", "noautocmd q" },
  { "qa!!", "noautocmd qa" },
  { "up!!", "noautocmd up" },
  { "wr!!", "noautocmd w" },
  { "wa!!", "noautocmd wa" },
  { "x!!", "noautocmd x" },

  -- closing buffers
  { "bufo", "BufOnly" },
  { "qb", "BufClose" },
  { "wqb", "BqWrite" },

  -- Lazy
  { "LZ", "Lazy" },
  { "LZI", "Lazy install" },
  { "LZS", "Lazy sync" },
  { "LZC", "Lazy clean" },

  -- LSP
  { "LA", "LspStart" },
  { "LI", "LspInfo" },
  { "LL", "LspLog" },
  { "LO", "LspStop" },
  { "LR", "LspRestart" },

  -- sessions
  { "SS", "SessionSave" },
  { "SD", "SessionDelete" },
  { "DS", "SessionDelete" },

  -- tabs
  { "tq", "tabclose" },
  { "to", "tabonly" },

  -- other plugins
  { "DO", "DiffviewOpen" },
  { "DH", "DiffviewFileHistory" },
  { "%", "FP" },
}, "c")
