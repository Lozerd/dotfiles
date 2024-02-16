return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        { "junegunn/fzf", build = "./install --bin" }
    },
    config = function()
        local fzf = require("fzf-lua")

        fzf.setup({
            previewers = {
                bat = {
                    cmd = "batcat"
                }
            }
        })

        vim.keymap.set("n", "<leader>pg", fzf.live_grep_resume, { desc = "[P]roject [S]trings (fzf)" })



        vim.keymap.set("n", "<leader><C-e>", fzf.oldfiles, { desc = "[C-e] View recent files" })
        vim.keymap.set("n", "<leader><space>", fzf.buffers, { desc = "[ ] Find existing buffers" })
        vim.keymap.set("n", "<leader>/", fzf.lgrep_curbuf, { desc = "[/] Fuzzily search in current buffer" })
        vim.keymap.set("n", "<leader>pf", function()
            fzf.files({ hidden = true })
        end, { desc = "[P]roject [F]iles" })
        vim.keymap.set("n", "<leader>phf", function()
            fzf.live_grep({ additional_args = { "-u" } })
        end, { desc = "[P]roject [H]idden [F]iles" })

        vim.keymap.set("n", "<leader>ps", fzf.live_grep, { desc = "[P]roject [S]trings" })
    end
}
