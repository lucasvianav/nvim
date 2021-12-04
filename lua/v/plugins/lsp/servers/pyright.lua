local M = {}

M.settings = {
    python = {
        analysis = {
            extraPaths = { '.', './*', './**/*', './**/**/*' },
            useImportHeuristic = true,
        },
    },
}

return M
