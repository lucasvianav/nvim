local M = {}

M.config = {
  filetypes = {
    "aspnetcorerazor",
    "blade",
    "django-html",
    "edge",
    "ejs",
    "eruby",
    "gohtml",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "html-eex",
    "jade",
    "leaf",
    "liquid",
    -- 'markdown',
    "mdx",
    "mustache",
    "njk",
    "nunjucks",
    "php",
    "razor",
    "slim",
    "twig",
    "vue",
    "svelte",
  },
}

M.on_attach = require("v.utils.lsp.on_attach").disable_formatting

return M
