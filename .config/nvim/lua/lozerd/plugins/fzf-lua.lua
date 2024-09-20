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
            },
        })


        vim.keymap.set("n", "<leader><C-e>", fzf.oldfiles, { desc = "[C-e] View recent files" })
        vim.keymap.set("n", "<leader><space>", fzf.buffers, { desc = "[ ] Find existing buffers" })
        vim.keymap.set("n", "<leader>/", fzf.lgrep_curbuf, { desc = "[/] Fuzzily search in current buffer" })
        vim.keymap.set("n", "<leader>pf", function()
            fzf.files({ hidden = true })
        end, { desc = "[P]roject [F]iles" })

        vim.keymap.set("n", "<leader>nh", fzf.helptags, { desc = "[N]eovim [H]elptags" })

        -- vim.keymap.set("n", "<leader>ps", fzf.live_grep, { desc = "[P]roject [S]trings" })
        vim.keymap.set("n", "<leader>ps", fzf.live_grep_resume, { desc = "[P]roject [S]trings" })
        -- vim.keymap.set("n", "<leader>prs", fzf.live_grep_resume, { desc = "[P]roject [S]trings resume" }

        -- Git related staff
        vim.keymap.set("n", "<leader>gt", fzf.git_tags, { desc = "[G]it [T]tags" })
        vim.keymap.set("n", "<leader>gz", fzf.git_stash, { desc = "[G]it [S]stash" })
        vim.keymap.set("n", "<leader>gf", fzf.git_files, { desc = "[G]it [F]files" })
        vim.keymap.set("n", "<leader>gc", fzf.git_commits, { desc = "[G]it [C]commits" })
        vim.keymap.set("n", "<leader>gb", fzf.git_branches, { desc = "[G]it [B]branches" })
    end
}
