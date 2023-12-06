return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },             -- Required
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },     -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'L3MON4D3/LuaSnip' },     -- Required
    },
    config = function()
        local lsp = require("lsp-zero")
        local lsp_config = require("lspconfig")

        lsp.preset("recommended")

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "tsserver",
                "vuels",
                "cssls",
                "pylsp"
            },
            handlers = {
                vuels = function()
                    lsp_config.vuels.setup {
                        settings = {
                            vuels = {
                                vetur = {
                                    options = {
                                        tabSize = 4
                                    }
                                }
                            }
                        }
                    }
                end,
                pylsp = function()
                    lsp_config.pylsp.setup {
                        cmd = { "pylsp", "-v", "--log-file", "/tmp/nvim-pylsp.log" },
                        settings = {
                            pylsp = {
                                plugins = {
                                    rope = { ropeFolder = ".ropeproject" },
                                    jedi_completion = { enabled = true },
                                    pycodestyle = { enabled = false, maxLineLength = 120 },
                                    autopep8 = { enabled = true },
                                    black = {
                                        enabled = false,
                                        line_length = 120,
                                        skip_string_normalization = true,
                                        cache_config = true
                                    },
                                    pyflakes = { enabled = false },
                                    flake8 = { enabled = true, maxLineLength = 120, maxComplexity = 15 },
                                    rope_autoimport = { enabled = true },
                                    --     enabled = true,
                                    --     memory = false,
                                    --     code_actions = { enabled = true },
                                    --     completions = { enabled = true },
                                    -- },
                                    -- rope_completion = { enabled = true }
                                },
                            },
                        },
                        on_attach = on_attach
                    }
                end
            }
        })

        -- lsp.nvim_workspace()

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        local cmp_mappings = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<Tab>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true
            }),
            ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
            ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        })

        cmp_mappings["<S-Tab>"] = nil
        cmp.setup({
            mapping = cmp_mappings
        })

        --cmp_mappings["<Tab>"] = nil

        -- lsp.setup_nvim_cmp({
        --     mapping = cmp_mappings
        -- })

        function on_attach(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            vim.keymap.set("v", "<leader><S-r>", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("n", "<C-A-O>",
                function()
                    local filter = function(action) return action.kind == "source.organizeImports" end
                    vim.lsp.buf.code_action({ filter = filter, apply = true })
                end, opts
            )

            -- git-blame
            vim.keymap.set("n", "<leader>gbo", "<cmd>GitBlameOpenCommitURL<CR>", opts)
        end

        lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = 'E',
                warn = 'W',
                hint = 'H',
                info = 'I'
            },
        })

        lsp.on_attach(on_attach)

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = "\u{ea71}" },
                severity_sort = true
            }
        )

        local signs = { Error = " ", Warn = " ", Hint = "󰌶", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        lsp.setup()

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
