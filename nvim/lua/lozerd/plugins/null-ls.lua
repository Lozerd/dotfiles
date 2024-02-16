return {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local builtins = require("null-ls.builtins")
        local formatting = builtins.formatting
        local diagnostics = builtins.diagnostics

        local ld = false
        local sources = {}

        -- ───────────────────────────────────────────────── --
        -- ─────────────────❰ FORMATTING ❱────────────────── --

        if vim.fn.executable("djlint") == 1 then
            ld = true
            sources[#sources + 1] = formatting.djlint.with({
                command = "djlint",
                args = {
                    "--reformat",
                    "-",
                    "--blank-line-after-tag",
                    "load,extends,include,endif,endfor,endcomment",
                    "--blank-line-before-tag",
                    "include,if,for,comment",
                    "--profile",
                    "django",
                    "--quiet",
                },
            })
        end

        if false and vim.fn.executable("black") == 1 then
            ld = true
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
        end
        -- ───────────────❰ end FORMATTING ❱──────────────── --
        -- ───────────────────────────────────────────────── --


        -- ───────────────────────────────────────────────── --
        -- ─────────────────❰ DIAGNOSTICS ❱───────────────── --

        --if vim.fn.executable("djlint") == 1 then
        --    ld = true
        --    sources[#sources + 1] = diagnostics.djlint.with({
        --        command = "djlint",
        --        args = { vim.fn.expand("%") }
        --    })
        --end

        -- ───────────────❰ end DIAGNOSTICS ❱─────────────── --
        -- ───────────────────────────────────────────────── --


        -- ───────────────────────────────────────────────── --
        -- ─────────────────❰ COMPLETIONS ❱───────────────── --



        -- ───────────────❰ end COMPLETIONS ❱─────────────── --
        -- ───────────────────────────────────────────────── --

        if ld then
            require("null-ls").setup({ sources = sources })
        end
    end
}

