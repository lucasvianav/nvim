-- TODO: review PRs in nvim
-- https://github.com/pwntester/octo.nvim
-- https://github.com/ldelossa/gh.nvim
-- https://medium.com/@cristianvg/quick-github-prs-searching-with-neovim-and-octo-18fd898da3dd
-- https://github.com/natdm/pulls.nvim
-- https://www.youtube.com/watch?v=hhrWwYfMK1I
-- https://www.youtube.com/watch?v=VFESU67M4bk

---@module "lazy.types"

---@type LazyPluginSpec[]
local M = {
  -- git CLI for command mode
  {
    "tpope/vim-fugitive",
    dependencies = "tpope/vim-rhubarb", -- integration with GitHub
    event = "VeryLazy",
    commit = "4a745ea72fa93bb15dd077109afbb3d1809383f2",
  },

  -- git decorations
  {
    "lewis6991/gitsigns.nvim",
    dependencies = "plenary.nvim",
    event = "VeryLazy",
    commit = "8bdaccdb897945a3c99c1ad8df94db0ddf5c8790",
  },

  -- practical git diff for modified files
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    dependencies = "devicons",
    commit = "4516612fe98ff56ae0415a259ff6361a89419b0a",
  },
}

return require("v.lazy.loader").process_plugins(M, "git")
