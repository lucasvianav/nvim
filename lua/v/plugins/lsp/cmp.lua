-- TODO: https://github.com/petertriho/cmp-git
-- https://www.reddit.com/r/neovim/comments/r42njg/here_are_the_vs_code_theme_colors_for_the_new/hme3pb7/
-- https://github.com/hrsh7th/nvim-cmp/issues/465#issuecomment-981159946

local cmp = require('cmp')

local ok_lspkind, lspkind = pcall(require, 'lspkind')
if ok_lspkind then
  lspkind.init()
else
  require('v.utils.log').log(lspkind)
  vim.api.nvim_notify("Couldn't load `lspkind`.", vim.log.levels.ERROR, {
    title = 'Error - CMP',
  })
end

local ok_comparator, comparator = pcall(require, 'cmp-under-comparator')
if not ok_comparator then
  require('v.utils.log').log(comparator)
  vim.api.nvim_notify("Couldn't load `cmp-under-comparator`.", vim.log.levels.ERROR, {
    title = 'Error - CMP',
  })
end

-- TODO FIXME ???? fix this pls
local armengue = 0
local cmdline_escape = function()
  cmp.mapping.abort()
  if armengue > 1 then
    vim.api.nvim_feedkeys('<ESC>', 'c', true)
  else
    armengue = armengue + 1
  end
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },

  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<Esc>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmdline_escape(),
    }),
    ['<C-c>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmdline_escape(),
    }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping({
      i = function(fallback)
        if vim.fn['UltiSnips#CanJumpForwards']() == 1 then
          vim.fn['UltiSnips#JumpForwards']()
        elseif cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          fallback()
        end
      end,
    }),
    ['<S-Tab>'] = cmp.mapping({
      i = function(fallback)
        if vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
          vim.fn['UltiSnips#JumpBackwards']()
        elseif cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
          fallback()
        end
      end,
    }),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'ultisnips' },
    { name = 'path' },
    { name = 'spell' },
    { name = 'cmdline' },
    { name = 'buffer', keyword_length = 5 },
    { name = 'calc' },
  }),

  -- completion = {
  --     autocomplete = false,
  -- },

  formatting = {
    format = ok_lspkind and lspkind.cmp_format({
      with_text = true,
      maxwidth = 50,
      menu = {
        buffer = '[Buf]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[Lua]',
        path = '[Path]',
        cmdline = '[CMD]',
      },
    }) or nil,
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      ok_comparator and require('cmp-under-comparator').under or nil,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  experimental = {
    ghost_text = true,
  },

  window = {
    documentation = {
      border = 'single',
    },
  },
})

-- add parenthesis on function/method completion
local ok_npairs, npairs_cmp = pcall(require, 'nvim-autopairs.completion.cmp')
if ok_npairs then
  cmp.event:on(
    'confirm_done',
    npairs_cmp.on_confirm_done({
      map_char = { tex = '' },
    })
  )
else
  require('v.utils.log').log(npairs_cmp)
  vim.api.nvim_notify(
    "Couldn't load `nvim-autopairs.completion.cmp`.",
    vim.log.levels.ERROR,
    { title = 'Error - CMP' }
  )
end

local __search_sources = {
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' },
  }, {
    { name = 'buffer' },
  }),
}

-- use buffer source for `?`
cmp.setup.cmdline('?', __search_sources)

-- use buffer source for `/`
cmp.setup.cmdline('/', __search_sources)

-- use cmdline and path source for ':'
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})
