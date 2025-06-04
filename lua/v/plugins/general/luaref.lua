require("v.utils.autocmds").augroup("LuarefFiltype", {
  {
    event = "BufRead",
    opts = {
      pattern = vim.fs.joinpath(
        require("v.lazy.utils").paths.plugins,
        "nvim-luaref",
        "doc",
        "lua_reference.txt"
      ),
      command = "setlocal filetype=help",
    },
  },
})
