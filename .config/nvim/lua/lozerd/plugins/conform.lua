return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        }
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "autopep8" },
        },
        formatters = {
            autopep8 = {
                prepend_args = { "--max-line-length", "120" }
            }
        }
    }
}
