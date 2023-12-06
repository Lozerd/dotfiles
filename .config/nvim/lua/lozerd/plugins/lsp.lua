return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' }
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        function on_attach(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            vim.keymap.set("v", "<leader><S-r>", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("n", "<M-CR>", function()
                vim.lsp.buf.code_action({ context = { only = { "quickfix" } } })
            end, opts)
            vim.keymap.set("n", "<C-A-O>", function()
                local filter = function(action) return action.kind == "source.organizeImports" end
                vim.lsp.buf.code_action({ filter = filter, apply = true })
            end, opts)

            -- git-blame
            vim.keymap.set("n", "<leader>gbo", "<cmd>GitBlameOpenCommitURL<CR>", opts)
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        local signs = { Error = " ", Warn = " ", Hint = "󰌶", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        local disabled = { enabled = false }
        lspconfig["pylsp"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "pylsp", "-v", "--log-file", "/tmp/nvim-pylsp.log" },
            settings = {
                pylsp = {
                    plugins = {
                        rope = { ropeFolder = ".ropeproject" },
                        pydocstyle = disabled,
                        pycodestyle = disabled,
                        pyflakes = disabled,
                        pylint = disabled,
                        flake8 = { enabled = true, maxLineLength = 120, maxComplexity = 15 },
                        autopep8 = { enabled = true },
                        black = disabled,
                        jedi_completion = { enabled = true },
                        rope_autoimport = {
                            enabled = true,
                            memory = false,
                            code_actions = { enabled = true },
                            completions = { enabled = true },
                        },
                        rope_completion = { enabled = true }
                    },
                },
            },
        })

        lspconfig["vuels"].setup({
            settings = {
                vuels = {
                    vetur = {
                        options = {
                            tabSize = 4
                        }
                    }
                }
            }
        })

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        -- lsp.set_preferences({
        --     suggest_lsp_servers = false,
        --     sign_icons = {
        --         error = 'E',
        --         warn = 'W',
        --         hint = 'H',
        --         info = 'I'
        --     },
        -- })

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = "\u{ea71}" },
                severity_sort = true
            }
        )

        vim.diagnostic.config({
            virtual_text = {
                prefix = "●"
            },
            update_in_insert = true,
            float = {
                source = "always",
            },
        })
    end
}
