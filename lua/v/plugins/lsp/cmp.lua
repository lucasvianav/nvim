local cmp = require("cmp")
local hover_config = require("v.lsp.hover").hover_config

local ok_lspkind, lspkind = pcall(require, "lspkind")
if not ok_lspkind then
  require("v.utils.log").log(lspkind)
  vim.notify("Couldn't load `lspkind`.", vim.log.levels.ERROR, {
    title = "[nvim-cmp]",
  })
end

local ok_colorful_menu, colorful_menu = pcall(require, "colorful-menu")
if not ok_colorful_menu then
  require("v.utils.log").log(lspkind)
  vim.notify("Couldn't load `ok_colorful_menu`.", vim.log.levels.ERROR, {
    title = "[nvim-cmp]",
  })
end

local ok_comparator, comparator = pcall(require, "cmp-under-comparator")
if not ok_comparator then
  require("v.utils.log").log(comparator)
  vim.notify("Couldn't load `cmp-under-comparator`.", vim.log.levels.ERROR, {
    title = "Error - CMP",
  })
end

local custom_kind = {
  calc = "󰃬",
}

local close_cmdline = false
local cmp_abort = cmp.mapping.abort()
local function cmdline_escape(...)
  cmp_abort(...)
  if close_cmdline then
    vim.api.nvim_feedkeys(t("<ESC>"), "c", true)
  end
  close_cmdline = not close_cmdline
end

-- TODO: https://github.com/tzachar/cmp-fuzzy-buffer
-- TODO: https://github.com/tzachar/cmp-fuzzy-path
-- TODO: https://github.com/quangnguyen30192/cmp-nvim-tags
-- TODO: https://gist.github.com/jsr-p/93cfeda90588365feefaf4a8c78ff086
-- TODO: https://github.com/onsails/lspkind.nvim/pull/30
-- TODO: https://www.reddit.com/r/neovim/comments/1l075d8/with_cmp_why_is_the_lsp_entry_prioritized_by/?share_id=7C-5lLAYOPjYkXMS2aZXh&utm_medium=android_app&utm_name=androidcss&utm_source=share&utm_term=2

local window_conf = cmp.config.window.bordered({
  scrollbar = false,
  bootstrap = "rounded",
})

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
    completion = window_conf,
    documentation = window_conf,
  },
  experimental = {
    ghost_text = true,
  },
  mapping = {
    -- scroll docs
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

    -- trigger completion
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

    -- abort
    ["<Esc>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmdline_escape,
    }),
    ["<C-c>"] = cmp.mapping({
      i = cmp.mapping.abort(),
    }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),

    -- select completion
    ["<cr>"] = cmp.mapping.confirm({ select = false }),
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),

    -- expand snippets
    ["<Tab>"] = cmp.mapping({
      i = function(fallback)
        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.fn["UltiSnips#JumpForwards"]()
        else
          fallback()
        end
      end,
    }),
    ["<S-Tab>"] = cmp.mapping({
      i = function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          vim.fn["UltiSnips#JumpBackwards"]()
        else
          fallback()
        end
      end,
    }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "ultisnips" },
    { name = "path" },
    { name = "spell" },
    { name = "buffer", keyword_length = 5 },
    { name = "calc" },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = ok_lspkind
          and lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = {
              menu = hover_config.max_width,
              abbr = 50,
            },
            ellipsis_char = "...",
            show_labelDetails = true,
            menu = {
              buffer = "[Buf]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
              path = "[Path]",
              cmdline = "[CMD]",
              ultisnips = "[Snip]",
            },
          })(entry, vim.deepcopy(vim_item))
        or nil
      local highlights_info = ok_colorful_menu and colorful_menu.cmp_highlights(entry) or nil

      if highlights_info ~= nil then
        vim_item.abbr_hl_group = highlights_info.highlights
        vim_item.abbr = highlights_info.text
      end

      if kind then
        vim_item.kind = " " .. kind.kind .. " "
        vim_item.menu = kind.menu
      end

      if custom_kind[entry.source.name] then
        vim_item.kind = " " .. custom_kind[entry.source.name] .. " "
      end

      return vim_item
    end,
  },
  sorting = {
    priority_weight = 1,
    comparators = vim
      .iter({
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        ok_comparator and require("cmp-under-comparator").under or nil,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      })
      :filter(function(it)
        return it ~= nil
      end)
      :totable(),
  },
})

-- add parenthesis on function/method completion
-- ALT: https://github.com/hrsh7th/nvim-cmp/issues/465#issuecomment-981159946
local ok_npairs, npairs_cmp = pcall(require, "nvim-autopairs.completion.cmp")
if ok_npairs then
  cmp.event:on(
    "confirm_done",
    npairs_cmp.on_confirm_done({
      map_char = { tex = "" },
    })
  )
else
  require("v.utils.log").log(npairs_cmp)
  vim.notify(
    "Couldn't load `nvim-autopairs.completion.cmp`.",
    vim.log.levels.ERROR,
    { title = "[nvim-cmp]" }
  )
end

-- use lsp and buffer source for `/` and `?`
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol" },
  }, {
    { name = "buffer" },
  }),
})

-- use cmdline and path source for ':'
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  matching = {
    disallow_symbol_nonprefix_matching = false,
    disallow_fullfuzzy_matching = false,
    disallow_fuzzy_matching = false,
    disallow_partial_fuzzy_matching = false,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = false,
  },
})
