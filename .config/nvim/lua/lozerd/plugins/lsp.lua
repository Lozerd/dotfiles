return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' }
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        function on_attach(bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            vim.keymap.set({ "n", "v" }, "<leader>r", function() vim.lsp.buf.rename() end, opts)
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

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('LozerdLspConfig', {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                on_attach(ev.bufnr)
            end
        })

        local capabilities = cmp_nvim_lsp.default_capabilities()

        local signs = { Error = " ", Warn = " ", Hint = "󰌶", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        local tox_config_dir = function()
            local dir = vim.fn.getcwd() .. "/tox.ini"
            if vim.fn.filereadable(dir) then
                return dir
            else
                return nil
            end
        end
        local disabled = { enabled = false }

        -- ───────────────────────────────────────────────── --
        -- ───────────────────❰ Python ❱──────────────────── --

        lspconfig["pyright"].setup({
            on_attach=on_attach,
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        diagnosticSeverityOverrides = {
                            -- reportAssignmentType = "none",
                        },
                    }
                }
            }
        })

        lspconfig["pylsp"].setup({
            capabilities = capabilities,
            cmd = { "pylsp", "-v", "--log-file", "/tmp/nvim-pylsp.log" },
            settings = {
                pylsp = {
                    plugins = {
                        autopep8 = { enabled = true, maxLineLength = 120 },
                        -- autopep8 = disabled,
                        flake8 = {
                            enabled = true,
                            config = tox_config_dir(),
                            maxLineLength = 120,
                            maxComplexity = 15
                        },
                        -- jedi = disabled,
                        jedi_completion = disabled,
                        -- jedi_definition = disabled,
                        jedi_hover = disabled,
                        jedi_references = disabled,
                        jedi_signature_help = disabled,
                        jedi_symbols = disabled,
                        mccabe = disabled,
                        preload = disabled,
                        pycodestyle = { enabled = true, maxLineLength = 120 },
                        pydocstyle = {
                            enabled = true,
                            ignore = {
                                "D100", "D101", "D102", "D105", "D106", "D107",
                                "D203", "D210", "D212", "D205"
                            }
                        },
                        pyflakes = disabled,
                        pylint = disabled,
                        rope_autoimport = disabled,
                        rope_completion = disabled,
                        -- yapf = disabled,
                        black = disabled,
                        rope = { ropeFolder = ".ropeproject" },
                    },
                },
            },
        })

        -- ───────────────────────────────────────────────── --
        -- ─────────────────❰ JavaScript ❱────────────────── --

        lspconfig["tsserver"].setup({})
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
            settings = { -- custom settings for lua
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
                },
            },
        })

        lspconfig["kotlin_language_server"].setup({})

        lspconfig["clangd"].setup({})

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
