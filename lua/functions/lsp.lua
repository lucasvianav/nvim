local lsp  = vim.lsp
local fn   = vim.fn
local api  = vim.api
local cmd  = vim.cmd
local util = lsp.util

--[[
Built-in LSP's GoToDefinition handler that supports splitting.
]]--
function _G.goto_definition(split_cmd)
    local log = require("vim.lsp.log")

    -- (_, result, {method=method})
    local handler = function(_, method, result )
        if result == nil or vim.tbl_isempty(result) then
            local _ = log.info() and log.info(method, "No location found")
            return nil
        end

        if split_cmd then
            if contains(split_cmd, { 'split', 'vsplit' }) then
                cmd(split_cmd)
            else
                cmd('vsplit')
            end
        end

        if vim.tbl_islist(result) then
            util.jump_to_location(result[1])

            if #result > 1 then
                util.set_qflist(util.locations_to_items(result))
                api.nvim_command("copen")
                api.nvim_command("wincmd p")
            end
        else
            util.jump_to_location(result)
        end
    end

    return handler
end





local function peek_definitin_callback(_, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end

    lsp.util.preview_location(result[1])
end

--[[
Analogue to VSCode's PeekDefiniton.
]]--
function _G.peek_definition()
    return vim.lsp.buf_request(
        0,
        'textDocument/definition',
        lsp.util.make_position_params(),
        peek_definitin_callback
    )
end





local orig_set_signs = vim.lsp.diagnostic.set_signs

--[[
Get most severe diagnostic sign per line.
]]--
function _G.set_signs_limited(diagnostics, bufnr, client_id, sign_ns, opts)
    -- original func runs some checks, which I
    -- think is worth doing but maybe overkill
    if not diagnostics then
        diagnostics = diagnostic_cache[bufnr][client_id]
    end

    -- early escape
    if not diagnostics then
        return
    end

    -- work out max severity diagnostic per line
    local max_severity_per_line = {}
    for _, d in pairs(diagnostics) do
        if max_severity_per_line[d.range.start.line] then
            local current_d = max_severity_per_line[d.range.start.line]

            if d.severity < current_d.severity then
                max_severity_per_line[d.range.start.line] = d
            end
        else
            max_severity_per_line[d.range.start.line] = d
        end
    end

    -- map to list
    local filtered_diagnostics = {}
    for i, v in pairs(max_severity_per_line) do
        table.insert(filtered_diagnostics, v)
    end

    -- call original func
    orig_set_signs(filtered_diagnostics, bufnr, client_id, sign_ns, opts)
end

