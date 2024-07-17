return {
    settings = {         -- custom settings for lua
        Lua = {
            runtime = { version = "LuaJIT" },
            -- make the language server recognize "vim" global
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
                -- make language server aware of runtime files
                library = {
                    -- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    -- [vim.fn.stdpath("config") .. "/lua"] = true,
                    "${3rd}/luv/library",
                    unpack(vim.api.nvim_get_runtime_file("", true)),
                },
            },
            telemetry = { enabled = false }
        },
    },
}
