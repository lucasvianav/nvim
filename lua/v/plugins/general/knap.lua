vim.g.knap_settings = {
  texoutputext = 'pdf',
  textopdf = 'tectonic -X compile %srcfile% --synctex --keep-logs --keep-intermediates',
  textopdfforwardjump = false,
  textopdfviewerlaunch =
  "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --new-instance %outputfile%",
}

require('v.utils.commands').command('Prev', 'lua require("knap").toggle_autopreviewing()')
require('v.utils.mappings').map({
  { 'n', 'v', 'i' },
  '<F7>',
  function()
    require('knap').toggle_autopreviewing()
  end,
})
