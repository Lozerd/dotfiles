local fzf = require("fzf-lua")


vim.keymap.set("n", "<leader>pg", fzf.live_grep_resume, { desc = "[P]roject [S]trings (fzf)" })
