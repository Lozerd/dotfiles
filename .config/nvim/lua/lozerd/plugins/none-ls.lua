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
                "tsserver",
                "vuels",
                "cssls",
                "lua_ls",
                "pylsp",
            },
        })

        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics

        local sources = {}

        -- ───────────────────────────────────────────────── --
        -- ─────────────────❰ FORMATTING ❱────────────────── --

        if vim.fn.executable("djlint") == 1 then
            sources[#sources + 1] = formatting.djlint.with({
                command = "djlint",
                args = {
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

        if false and vim.fn.executable("black") == 1 then
            sources[#sources + 1] = formatting.black.with({
                command = "black",
                args = {
                    "--fast",
                    "--quiet",
                    "--line-length",
                    "120",
                    "--skip-string-normalization",
                }
            })
            --sources[#sources+1] = formatting.black.with({ })
        end
        -- ───────────────────────────────────────────────── --
        -- ─────────────────❰ DIAGNOSTICS ❱───────────────── --

        if vim.fn.executable("djlint") == 1 then
            sources[#sources + 1] = diagnostics.djlint.with({
                command = "djlint",
                args = { vim.fn.expand("%") }
            })
        end

        null_ls.setup({
            sources = sources
        })
    end
}
