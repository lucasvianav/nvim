P("CALLED", "CALLED", "CALLED")

local config = require("v.utils.lsp").make_config()
local ok, ts_ls = pcall(require, "v.plugins.lsp.servers.ts_ls")

if ok then
  config = vim.tbl_deep_extend("force", config, ts_ls.config)
end

require("typescript-tools").setup(P(vim.tbl_deep_extend("keep", config, {
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    tsserver_max_memory = 8192,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = "all",
    -- described below
    tsserver_format_options = {
      insertSpaceAfterCommaDelimiter = true,
      insertSpaceAfterSemicolonInForStatements = true,
      insertSpaceBeforeAndAfterBinaryOperators = true,
      insertSpaceAfterConstructor = true,
      insertSpaceAfterKeywordsInControlFlowStatements = true,
      insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
      insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
      insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
      insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
      insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
      insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
      insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
      insertSpaceAfterTypeAssertion = true,
      insertSpaceBeforeFunctionParenthesis = false,
      placeOpenBraceOnNewLineForFunctions = false,
      placeOpenBraceOnNewLineForControlBlocks = false,
      insertSpaceBeforeTypeAnnotation = true,
      semicolons = "insert",
    },
    tsserver_file_preferences = {
      includeCompletionsWithSnippetText = true,
      includeCompletionsForImportStatements = true,
      includeCompletionsWithInsertText = true,
      includeAutomaticOptionalChainCompletions = true,
      includeCompletionsWithClassMemberSnippets = true,
      includeCompletionsWithObjectLiteralMethodSnippets = true,
      importModuleSpecifierEnding = "minimal",
      jsxAttributeCompletionStyle = "braces",
      displayPartsForJSDoc = true,
      generateReturnInDocTemplate = true,
      includeInlayParameterNameHints = "all",
    },
    tsserver_locale = "en",
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    code_lens = "off", -- experimental
    disable_member_code_lens = true,
    jsx_close_tag = { -- handled by [nvim-ts-autotag] already
      enable = false,
      filetypes = { "javascriptreact", "typescriptreact" },
    },
  },
})))
