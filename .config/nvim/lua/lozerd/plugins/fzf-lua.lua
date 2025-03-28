return {
    "ibhagwan/fzf-lua",
    -- commit = "6b5c48fe40695c0b1df61c1bbf7fdcfca04c7e16",
    dependencies = {
        { "nvim-tree/nvim-web-devicons", config = { variant = "light|dark" } },
        {
            "junegunn/fzf",
            -- commit = "a2c365e7103622cbe313f846675af0cb0826ebca",
            build = "./install --bin"
        }
    },
    config = function()
        local fzf = require("fzf-lua")

        fzf.setup({
            previewers = { bat = { cmd = "batcat" } },
            keymap = { fzf = { ["ctrl-q"] = "select-all+accept", } },
            files = {
                fd_opts = [[ --color=never --hidden --type f --type l -E '*min.js' -E .git ]]
            },
            grep = {
                rg_opts = table.concat({
                    "--column", "--line-number", "--no-heading", "--color=always", "--smart-case",
                    "--max-columns=4096", "-g '!*.min.js'", "-e "
                }, " "),
            },
            colorschemes = {
                preview = "onedark"
            }
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
