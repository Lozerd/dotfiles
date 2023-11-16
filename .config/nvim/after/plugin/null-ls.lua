local builtins = require("null-ls.builtins")
local formatting = builtins.formatting
local diagnostics = builtins.diagnostics

local ld = false
local sources = {}

-- ───────────────────────────────────────────────── --
-- ─────────────────❰ FORMATTING ❱────────────────── --

print()

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
