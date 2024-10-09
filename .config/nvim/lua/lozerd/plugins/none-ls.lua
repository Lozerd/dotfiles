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

        if vim.fn.executable("djlint") == 1 then
            sources[#sources + 1] = formatting.djlint.with({
                command = "djlint",
                filetypes = { "html", "jinja2" },
                args = {
                    vim.fn.expand("%"),
                    "--reformat",
                    "-",
                    "--blank-line-after-tag",
                    "load,extends,include,endif,endfor,endcomment",
                    "--blank-line-before-tag",
                    "include,if,for,comment",
                    "--max-attribute-length",
                    "120",
                    "--profile",
                    "django",
                    "--quiet",
                },
            })
        end

        -- ───────────────❰ end FORMATTING ❱──────────────── --
        -- ───────────────────────────────────────────────── --

        -- ───────────────────────────────────────────────── --
        -- ─────────────────❰ DIAGNOSTICS ❱───────────────── --

        if vim.fn.executable("djlint") == 1 then
            sources[#sources + 1] = diagnostics.djlint.with({
                command = "djlint",
                filetypes = { "html", "jinja2" },
                args = { vim.fn.expand("%") }
            })
        end

        if vim.fn.executable("eslint") == 1 then
            sources[#sources + 1] = diagnostics.eslint.with({
                filetypes = { "html", "jinja2" },
            })
        end


        -- ───────────────❰ end DIAGNOSTICS ❱──────────────── --
        -- ───────────────────────────────────────────────── --


        -- ───────────────────────────────────────────────── --
        -- ─────────────────❰ DIAGNOSTICS ❱───────────────── --

        if vim.fn.executable("eslint") == 1 then
            sources[#sources + 1] = code_actions.eslint.with({
                filetypes = { "html", "jinja2" },
            })
        end

        -- ───────────────❰ end DIAGNOSTICS ❱──────────────── --
        -- ───────────────────────────────────────────────── --

        null_ls.setup({
            sources = sources
        })
    end
}
