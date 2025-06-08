---@meta _

---@class GrepOptions
---@field cwd?                  string          root dir to search from
---@field search?               string          the query to search
---@field grep_open_files?      boolean         restrict search to open files
---@field search_dirs?          table           directory/directories/files to search
---@field use_regex?            boolean         if true, special characters won't be escaped
---@field word_match?           string          exact word matching
---@field additional_args?      function|table  additional arguments to be passed on
---@field disable_coordinates?  boolean         don't show the line and row numbers
---@field only_sort_text?       boolean         only sort the text (not file, line, row)
---@field file_encoding?        string          file encoding for the entry
---@field prompt_title?         string          title of the prompt box
---@field results_title?        string          tile of the results box

---@class PickerShortcutAction
---@field glob? string
---@field fzf_token? string
---@field path? string
---@field flag? string
---@field flags? string[]
---@field extension? string
---@field extensions? string[]
---@field debug? boolean|PickerDebugTarget true = "parser"
---@field regex? string meant to be passed to the live finder

---@alias PickerDebugTarget "parser"|"sorter"|"finder"|"parser_shortcut_parts"

---@alias PickerShortcutDefinition PickerShortcutAction|fun(shortcut: string): PickerShortcutAction?

---@class PickerShortcutTable
---@field [string] PickerShortcutDefinition?
---@field [1] table<string|string[], PickerShortcutDefinition>

---@class PickerProcessedShortcut
---@field flags string[]
---@field globs string[]
---@field paths string[]
---@field extensions string[]
---@field fzf_tokens string[]
---@field debug PickerDebugTarget[]
---@field regex string meant to be passed to the live finder
