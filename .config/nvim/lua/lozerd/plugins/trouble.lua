return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        use_diagnostic_signs = true
    },
    config = function()
        local trouble = require("trouble")
        vim.keymap.set("n", "<leader>tt", function() trouble.toggle() end)
        vim.keymap.set("n", "<leader>tn", function() trouble.next({ skip_groups = true, jump = true }) end)
        vim.keymap.set("n", "<leader>tp", function() trouble.toggle({ skip_groups = true, jump = true }) end)
    end
}
