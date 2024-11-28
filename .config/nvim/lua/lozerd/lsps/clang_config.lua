return {
    on_init = function(client, initialization_result)
        if client.server_capabilities then
            client.server_capabilities.semanticTokensProvider = false -- turn off semantic tokens
        end
    end,
}
