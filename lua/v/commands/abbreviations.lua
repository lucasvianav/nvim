require('v.utils.abbreviations').set_abbreviations({
  -- commands I always get wrong
  { 'E',    'e' },
  { 'E!',   'e!' },
  { 'e1',   'e!' },
  { 'E1',   'e!' },
  { 'Q',    'q' },
  { 'q1',   'q!' },

  -- overwriting
  { 'W',    'up' },
  { 'w',    'up' },
  { 'Wq',   'x' },
  { 'wq',   'x' },

  -- no autocommands
  { 'q!!',  'noautocmd q' },
  { 'qa!!', 'noautocmd qa' },
  { 'up!!', 'noautocmd up' },
  { 'wr!!', 'noautocmd w' },
  { 'wa!!', 'noautocmd wa' },
  { 'x!!',  'noautocmd x' },

  -- closing buffers
  { 'bufo', 'BufOnly' },
  { 'qb',   'BufClose' },
  { 'wqb',  'BqWrite' },

  -- Packer
  { 'PS',   'PackerSync' },
  { 'PC',   'PackerCompile' },
  { 'PL',   'PackerClean' },
  { 'PT',   'PackerStatus' },

  -- LSP
  { 'LA',   'LspStart' },
  { 'LI',   'LspInfo' },
  { 'LL',   'LspLog' },
  { 'LO',   'LspStop' },
  { 'LR',   'LspRestart' },

  -- sessions
  { 'SS',   'SessionSave' },
  { 'SD',   'SessionDelete' },

  -- tabs
  { 'tq',   'tabclose' },

  -- other plugins
  { 'DO',   'DiffviewOpen' },
  { 'DH',   'DiffviewFileHistory' },
}, 'c')
