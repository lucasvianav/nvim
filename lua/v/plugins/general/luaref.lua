require("v.utils.autocmds").augroup("LuarefFiltype", {
  {
    event = "BufRead",
    opts = {
      pattern = vim.fs.joinpath(
        require("v.utils.packer").get_plugin_path("nvim-luaref"),
        "doc",
        "lua_reference.txt"
      ),
      command = "setlocal filetype=help",
    },
  },
})
