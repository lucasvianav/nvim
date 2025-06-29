require("v.utils.mappings").map({
  "n",
  "<leader>u",
  function()
    vim.api.nvim_exec2("UndotreeToggle | UndotreeFocus", { output = false })
  end,
})
