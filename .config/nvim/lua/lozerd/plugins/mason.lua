return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                }
            }
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "tsserver",
                "vuels",
                "cssls",
                "pylsp",
            },
            -- handlers = {
            --     function(server_name)
            --         require("lspconfig")[server_name].setup {}
            --     end
            -- },
            automatic_installation = true,
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "tsserver",
                "vuels",
                "cssls",
                "lua_ls",
                "pylsp",
                -- "djlint",
            },
        })

        local function mason_package_path(package)
            local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
            return path
        end

        -- depends on package manager / language
        local command = "/venv/bin/pip"
        local args = { "install", "pylsp-rope" }
        local cwd = mason_package_path("python-lsp-server")

        require("plenary.job")
            :new({
                command = cwd .. command,
                args = args,
                cwd = cwd,
            })
            :start()
    end
}
