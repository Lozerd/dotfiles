return {
    cmd = { "basedpyright-langserver", "--stdio", "--max-old-space-size=1000" },
    -- Disable ugly Lsp syntax overriden highlighting
    -- client.server_capabilities.semanticTokensProvider = nil
    on_init = function(client, initialization_result)
        if client.server_capabilities then
            client.server_capabilities.semanticTokensProvider = false  -- turn off semantic tokens
        end
    end,
    capabilities = {
        textDocument = {
            semanticTokens = {},
            -- semanticTokens = {
            --     augmentsSyntaxTokens = false
            -- },
        },
    },
    settings = {
        basedpyright = {
            analysis = {
                exclude = {'venv', 'env', '.git', '**/__pycache_', '**/.*', },
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                -- stubPath = "/home/lozerd/.virtualenvs/typings/",
                typeCheckingMode = "basic",
                -- typeshedPaths = {},
            },
            disableLanguageServices = false,
            disableOrganizeImports = false,
            disableTaggedHints = false,
            importStrategy = "fromEnvironment",
            -- pythonPath = "python",
            -- venvPath = "env"
        },
    }
}
