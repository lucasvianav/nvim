---@type (LazyPluginSpec|string)[]
local M = {
  "NTBBloodbath/doom-one.nvim",
  "navarasu/onedark.nvim",
  "folke/tokyonight.nvim",
  "shaunsingh/nord.nvim",
  "ishan9299/nvim-solarized-lua",
  "Th3Whit3Wolf/space-nvim",
  "marko-cerovac/material.nvim",
  "olimorris/onedarkpro.nvim",
  "rmehri01/onenord.nvim",
  "mrjones2014/lighthaus.nvim",
}

return require("v.lazy.loader").process_themes(M)
