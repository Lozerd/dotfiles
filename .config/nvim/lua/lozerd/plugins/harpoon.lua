return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon.setup({ settings = { sync_on_toggle = true, sync_on_ui_close = true } })

        vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
        vim.keymap.set("n", "<C-t>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        -- Harpoon -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-j>", function() harpoon:list():next() end)
        vim.keymap.set("n", "<C-k>", function() harpoon:list():prev() end)

        -- local mark = require("harpoon.mark")
        -- local ui = require("harpoon.ui")

        -- vim.keymap.set("n", "<leader>a", mark.add_file)
        -- vim.keymap.set("n", "<C-t>", ui.toggle_quick_menu)

        -- vim.keymap.set("n", "<C-j>", ui.nav_next)
        -- vim.keymap.set("n", "<C-k>", ui.nav_prev)
    end
}
