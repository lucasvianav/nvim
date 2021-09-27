local M = {}

M.filetypes = { 'json', 'jsonc' }

M.settings = {
    json = {
        -- https://www.schemastore.org
        schemas = {
            {
                fileMatch = {"package.json"},
                url = "https://json.schemastore.org/package.json"
            },
            {
                fileMatch = {"tsconfig*.json"},
                url = "https://json.schemastore.org/tsconfig.json"
            },
            {
                fileMatch = {
                    ".prettierrc", ".prettierrc.json",
                    "prettier.config.json"
                },
                url = "https://json.schemastore.org/prettierrc.json"
            },
            {
                fileMatch = {".eslintrc", ".eslintrc.json"},
                url = "https://json.schemastore.org/eslintrc.json"
            },
            {
                fileMatch = {
                    ".babelrc", ".babelrc.json", "babel.config.json"
                },
                url = "https://json.schemastore.org/babelrc.json"
            },
            {
                fileMatch = {"angular.json"},
                url = "https://raw.githubusercontent.com/angular/angular-cli/master/packages/angular/cli/lib/config/workspace-schema.json"
            },
            {
                fileMatch = {".angular-cli.json"},
                url = "https://raw.githubusercontent.com/angular/angular-cli/v10.1.6/packages/angular/cli/lib/config/schema.json"
            },
        }
    }
}

return M
