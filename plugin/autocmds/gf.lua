---@source: https://vim.fandom.com/wiki/Use_gf_to_open_a_file_via_its_URL

v.augroup("OpenFileUri", {
  {
    event = "BufReadCmd",
    opts = {
      pattern = "file:///*",
      callback = function()
        vim.api.nvim_exec2("bd! | edit " .. vim.uri_from_fname("<afile>"), { output = false })
      end,
    },
  },
})
