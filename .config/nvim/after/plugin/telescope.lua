local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup()

pcall(telescope.load_extension, "fzf")

vim.keymap.set("n", "<leader><C-e>", builtin.oldfiles, { desc = "[C-e] View recent files" })
vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        windblend = 10,
        previewer = false,
    })
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>pf", function()
    builtin.find_files({
        hidden = true
    })
end, { desc = "[P]roject [F]iles" })