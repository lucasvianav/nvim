local M = {
  -- beautiful notifications
  {
    "rcarriga/nvim-notify",
    commit = "b5825cf9ee881dd8e43309c93374ed5b87b7a896",
  },

  -- preserve window sizes on terminal resize
  {
    "kwkarlwang/bufresize.nvim",
    commit = "3b19527ab936d6910484dcc20fb59bdb12322d8b",
  },

  -- display opened tabs (2+)
  {
    "crispgm/nvim-tabline",
    commit = "287cd88157f98da76cb32ac7df7ec5c546414ec0",
  },

  -- improve vim.ui
  {
    "folke/snacks.nvim",
    commit = "bc0630e43be5699bb94dadc302c0d21615421d93",
  },

  -- colored matching brackets
  {
    "hiphish/rainbow-delimiters.nvim",
    after = "nvim-treesitter",
    commit = "55ad4fb76ab68460f700599b7449385f0c4e858e",
  },

  -- colored icons
  {
    "nvim-tree/nvim-web-devicons",
    as = "devicons",
    commit = "855c97005c8eebcdd19846f2e54706bffd40ee96",
  },

  -- colored color codes
  -- DEPENDENCY: Golang
  {
    "RRethy/vim-hexokinase",
    event = "CursorHold",
    run = "make hexokinase",
    commit = "62324b43ea858e268fb70665f7d012ae67690f43",
  },

  -- indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    after = "nvim-treesitter",
    commit = "005b56001b2cb30bfa61b7986bc50657816ba4ba",
  },

  -- colorcolumn with virtual text
  {
    "lukas-reineke/virt-column.nvim",
    event = {
      "CursorHold",
      "CursorMoved",
    },
    commit = "b87e3e0864211a32724a2ebf3be37e24e9e2fa99",
  },

  -- fancy statusline
  {
    "nvim-lualine/lualine.nvim",
    after = { "devicons" },
    commit = "15884cee63a8c205334ab13ab1c891cd4d27101a",
  },

  -- show cursor context in statusline
  {
    "SmiteshP/nvim-gps",
    after = "nvim-treesitter",
    disable = true,
  },
}

return M
