local M = {}
local diagnostics_visible = true

---Toggle vim.diagnostics (visibility only).
---@return nil
function M.toggle_visibility()
  if diagnostics_visible then
    vim.diagnostic.hide()
    diagnostics_visible = false
  else
    vim.diagnostic.show()
    diagnostics_visible = true
  end
end

---Filters diagnostigs leaving only the most severe per line.
---@param diagnostics table[]
---@return table[]
---@see https://www.reddit.com/r/neovim/comments/mvhfw7/can_built_in_lsp_diagnostics_be_limited_to_show_a/gvd8rb9/
---@see https://github.com/neovim/neovim/issues/15770
---@see https://github.com/akinsho/dotfiles/blob/d3526289627b72e4b6a3ddcbfe0411b5217a4a88/.config/nvim/plugin/lsp.lua#L83-L132
---@see diagnostic-handlers
local function filter_diagnostics(diagnostics)
  if not diagnostics then
    return {}
  end

  -- find the "worst" diagnostic per line
  local most_severe = {}
  for _, cur in pairs(diagnostics) do
    local max = most_severe[cur.lnum]

    -- higher severity has lower value (`:h diagnostic-severity`)
    if not max or cur.severity < max.severity then
      most_severe[cur.lnum] = cur
    end
  end

  -- return list of diagnostics
  return vim.tbl_values(most_severe)
end

local ns = vim.api.nvim_create_namespace("severe-diagnostics")
local orig_signs_handler = vim.diagnostic.handlers.signs

---@type vim.diagnostic.Handler
---@see diagnostic-handlers
M.signs_handler = {
  ---show the single most relevant diagnostic on the signcolumn
  show = function(_, bufnr, _, opts)
    local diagnostics = vim.diagnostic.get(bufnr)
    local filtered_diagnostics = filter_diagnostics(diagnostics)

    -- pass the filtered diagnostics (with the
    -- custom namespace) to the original handler
    orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
  end,

  hide = function(_, bufnr)
    orig_signs_handler.hide(ns, bufnr)
  end,
}

return M
