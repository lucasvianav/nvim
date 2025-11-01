vim.g.knap_settings = {
  texoutputext = "pdf",
  textopdf = "tectonic -X compile %srcfile% --synctex --keep-logs --keep-intermediates",
  -- textopdfviewerlaunch = "mupdf %outputfile%",
  -- textopdfviewerrefresh = "kill -HUP %pid%",

  textopdfviewerlaunch = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --new-window %outputfile%",
  textopdfviewerrefresh = "none",
  textopdfforwardjump = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,0)\"' --reuse-window --forward-search-file %srcfile% --forward-search-line %line% %outputfile%",
}

require("v.utils.commands").command("Prev", "lua require(\"knap\").toggle_autopreviewing()")
require("v.utils.mappings").map({
  { "n", "v", "i" },
  "<F7>",
  function()
    require("knap").toggle_autopreviewing()
  end,
})
