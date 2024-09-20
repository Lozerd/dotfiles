return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        use_diagnostic_signs = true
    },
    config = function()
        local trouble = require("trouble")

        vim.keymap.set(
            "n", "<leader>tt", 
            function() trouble.toggle("todo", { filter = { tag = { "TODO", "FIX", "FIXME" } } }) end,
            { silent = true, noremap = true, desc = "Toggle Trouble Todo" }
        )
        vim.keymap.set(
            "n", "<leader>td", function() trouble.toggle("diagnostics") end,
            { silent = true, noremap = true, desc = "Document Diagnostics" }
        )
        vim.keymap.set(
            "n", "<leader>tq", function() trouble.toggle("quickfix") end,
            { silent = true, noremap = true, desc = "Quickfix List" }
        )

        -- Navigation through diagnostics
        vim.keymap.set(
            "n", "<leader>tn", function() trouble.next({ skip_groups = true, jump = true })
            end, { desc = "Next Diagnostic Item" }
        )

        vim.keymap.set(
            "n", "<leader>tp", function() trouble.previous({ skip_groups = true, jump = true })
            end, { desc = "Previous Diagnostic Item" }
        )
    end
}
