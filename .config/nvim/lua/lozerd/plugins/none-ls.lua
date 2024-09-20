return {
    "nvimtools/none-ls.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local mason_null_ls = require("mason-null-ls")
        local null_ls = require("null-ls")

        mason_null_ls.setup({
            ensure_installed = {
                "ts_ls",
                "vuels",
                "cssls",
                "lua_ls",
                "pylsp",
                -- "djlint",
                "isort"
            },
        })

        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        local code_actions = null_ls.builtins.code_actions

        local sources = {}

        -- ───────────────────────────────────────────────── --
        -- ─────────────────❰ FORMATTING ❱────────────────── --

        -- if vim.fn.executable("djlint") == 1 then
        --     sources[#sources + 1] = formatting.djlint.with({
        --         command = "djlint",
        --         args = {
        --             "--reformat",
        --             "-",
        --             "--blank-line-after-tag",
        --             "load,extends,include,endif,endfor,endcomment",
        --             "--blank-line-before-tag",
        --             "include,if,for,comment",
        --             "--max-attribute-length",
        --             "120",
        --             "--profile",
        --             "django",
        --             "--quiet",
        --         },
        --     })
        -- end

        -- ───────────────❰ end FORMATTING ❱──────────────── --
        -- ───────────────────────────────────────────────── --

        -- ───────────────────────────────────────────────── --
        -- ─────────────────❰ DIAGNOSTICS ❱───────────────── --

        if vim.fn.executable("djlint") == 1 then
            sources[#sources + 1] = diagnostics.djlint.with({
                command = "djlint",
                args = { vim.fn.expand("%") }
            })
        end

        local flake8_config_dir = function()
            local dir = vim.fn.getcwd() .. "/tox.ini"
            if vim.fn.filereadable(dir) then
                return dir
            else
                return nil
            end
        end

        if vim.fn.executable("flake8") == 1 and false then
            sources[#sources + 1] = diagnostics.flake8.with({
                command = "flake8",
                args = {
                    vim.fn.expand("%:p"),
                    "--config",
                    flake8_config_dir(),
                    '--max-line-length',
                    '120',
                    'max-complexity',
                    '15'
                }
            })
        end

        if vim.fn.executable("mypy") == 1 and false then
            sources[#sources + 1] = diagnostics.mypy
            --[[
            sources[#sources + 1] = diagnostics.mypy.with({
                command = "mypy",
                args = {
                    vim.fn.expand("%:p"),
                    '--show-column-numbers',
                    '--show-error-end',
                    '--hide-error-codes',
                    '--hide-error-context',
                    '--no-color-output',
                    '--no-error-summary',
                    '--no-pretty',
                }
            })
            ]]--
        end

        -- enabled = true,
        -- config = flake8_config_dir(),
        -- maxLineLength = 120,
        -- maxComplexity = 15

        -- ───────────────❰ end DIAGNOSTICS ❱──────────────── --
        -- ───────────────────────────────────────────────── --


        null_ls.setup({
            sources = sources
        })
    end
}
