require('v.utils.packer').load_plugin('nvim-dap-vscode-js')
require('dap-vscode-js').setup({ adapters = { 'pwa-node' } })

local dap = require('dap')

for _, language in ipairs({ 'typescript', 'javascript' }) do
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    },
  }
end

local function set_breakpoint()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end

local function log_breakpoint()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end

local function repl_toggle()
  dap.repl.toggle(nil, 'botright split')
end

require('v.utils.mappings').set_keybindings({
  { 'n', '<leader>dL', log_breakpoint },
  { 'n', '<leader>db', dap.toggle_breakpoint },
  { 'n', '<leader>dB', set_breakpoint },
  { 'n', '<leader>dc', dap.continue },
  { 'n', '<leader>de', dap.step_out },
  { 'n', '<leader>di', dap.step_into },
  { 'n', '<leader>do', dap.step_over },
  { 'n', '<leader>dl', dap.run_last },
  { 'n', '<leader>dt', repl_toggle },
})
