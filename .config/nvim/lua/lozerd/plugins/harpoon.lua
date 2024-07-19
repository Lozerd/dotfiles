return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        local harpoon = require("harpoon")

        harpoon.setup({
            settings = {
                save_on_toggle = true
            }
        })

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-t>",
            function() harpoon.ui:toggle_quick_menu(harpoon:list(), { ui_width_ratio = 0.3 }) end)

        vim.keymap.set("n", "<C-j>", function() harpoon:list():next({ ui_nav_wrap = true }) end)
        vim.keymap.set("n", "<C-k>", function() harpoon:list():prev({ ui_nav_wrap = true }) end)
        --[[
        -- Harpoon main branch config
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file)
        vim.keymap.set("n", "<C-t>", ui.toggle_quick_menu)

        vim.keymap.set("n", "<C-j>", ui.nav_next)
        vim.keymap.set("n", "<C-k>", ui.nav_prev)
        ]] --
    end
}
