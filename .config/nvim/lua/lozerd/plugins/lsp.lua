return {
    "neovim/nvim-lspconfig",
    opts = { autoformat = false },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { { 'hrsh7th/cmp-nvim-lsp' }
    },
    config = function()
        local lspconfig = require("lspconfig")
        local util = require("lozerd.util")

        util.define_on_attach_autocmd()
        util.define_diagnostics()

        -- ───────────────────────────────────────────────── --
        -- ───────────────────❰ Python ❱──────────────────── --

        local server_names = {
            "basedpyright",
            "pylsp",
            "ts_ls",
            "vuels",
            "lua_ls",
            "kotlin_language_server",
            "clangd",
            "gopls",
        }

        for _, server_name in pairs(server_names) do
            lspconfig[server_name].setup(util.get_server_config(server_name))
        end
    end
}
