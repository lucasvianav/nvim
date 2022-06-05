local M = {}

M.cmd = {
  'arduino-language-server',
  '-cli-config',
  os.getenv('HOME') .. '/.arduino15/arduino-cli.yaml',
  '-fqbn',
  'arduino:avr:nano',
  '-cli',
  '/usr/bin/arduino-cli',
  '-clangd',
  '/usr/bin/clangd',
}

return M
