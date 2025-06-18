---@type (LazyPluginSpec|string)[]
local M = {
  "NTBBloodbath/doom-one.nvim",
  "Th3Whit3Wolf/space-nvim",
  "folke/tokyonight.nvim",
  "ishan9299/nvim-solarized-lua",
  "marko-cerovac/material.nvim",
  "mrjones2014/lighthaus.nvim",
  "navarasu/onedark.nvim",
  "olimorris/onedarkpro.nvim",
  "rmehri01/onenord.nvim",
  "shaunsingh/nord.nvim",
  { "catppuccin/nvim", name = "catppuccin" },
}

return require("v.lazy.loader").process_themes(M)
