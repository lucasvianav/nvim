local function set_opt(option, value)
    vim.g['lsp_utils_' .. option .. '_opts'] = value
end

local handlers = vim.lsp.handlers
local g = vim.g

handlers['textDocument/codeAction']     = require('lsputil.codeAction').code_action_handler
handlers['textDocument/references']     = require('lsputil.locations').references_handler
handlers['textDocument/definition']     = require('lsputil.locations').definition_handler
handlers['textDocument/declaration']    = require('lsputil.locations').declaration_handler
handlers['textDocument/typeDefinition'] = require('lsputil.locations').typeDefinition_handler
handlers['textDocument/implementation'] = require('lsputil.locations').implementation_handler
handlers['textDocument/documentSymbol'] = require('lsputil.symbols').document_handler

handlers['workspace/symbol']            = require('lsputil.symbols').workspace_handler

local border_chars = {
	TOP_LEFT = '┌',
	TOP_RIGHT = '┐',
	MID_HORIZONTAL = '─',
	MID_VERTICAL = '│',
	BOTTOM_LEFT = '└',
	BOTTOM_RIGHT = '┘',
}

set_opt('location', {
    height = 24,
    mode = 'editor',

    preview = {
        title = 'Location Preview',
        border = true,
        border_chars = border_chars
    },

    keymaps = {
        n = {
            ['<C-j>'] = 'j',
            ['<C-k>'] = 'k',
        },

        i = {
            ['<C-j>'] = '<C-n>',
            ['<C-k>'] = '<C-p>',
        }
    }
})

set_opt('symbols', {
    height = 24,
    mode = 'editor',

    preview = {
        title = 'Symbols Preview',
        border = true,
        border_chars = border_chars
    },

    keymaps = {
        n = {
            ['<C-j>'] = 'j',
            ['<C-k>'] = 'k',
        },

        i = {
            ['<C-j>'] = '<C-n>',
            ['<C-k>'] = '<C-p>',
        }
    },

    prompt = {},
})

set_opt('codeactions', {
    keymaps = {
        n = {
            ['<C-j>'] = 'j',
            ['<C-k>'] = 'k',
        },

        i = {
            ['<C-j>'] = '<C-n>',
            ['<C-k>'] = '<C-p>',
        }
    }
})

