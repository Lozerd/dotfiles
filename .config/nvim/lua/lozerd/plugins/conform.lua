return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    branch = "nvim-0.9",
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "n",
            desc = "Format buffer",
        },
        {
            "<leader>f",
            function()
                -- Function to format the selected range
                function FormatRange(start_line, end_line)
                    require('conform').format({
                        async = true,
                        start_line = start_line,
                        end_line = end_line,
                        bufnr = vim.api.nvim_get_current_buf(),
                    })
                end

                -- Create a command for range formatting
                vim.api.nvim_exec([[
                    command! -range=% FormatRange call v:lua.FormatRange(<line1>, <line2>)
                ]], false)

                -- Optional: Map a keybinding for range formatting in visual mode
                vim.api.nvim_set_keymap('v', '<leader>f', ':FormatRange<CR>', { noremap = true, silent = true })

                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "v",
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
                append_args = { "--max-line-length", "120" }
            },
            flake8 = {
                prepend_args = { "--max-line-length", "120" }
            }
        }
    }
}
