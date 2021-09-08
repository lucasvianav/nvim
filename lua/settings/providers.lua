local g = vim.g

-- setup executables for faster startup
g.python3_host_prog = '/usr/bin/python3'
-- g.node_host_prog = '/usr/bin/node'

-- disable languages I don't use
g.loaded_ruby_provider   = false
g.loaded_python_provider = false -- python 2
g.loaded_perl_provider   = false

