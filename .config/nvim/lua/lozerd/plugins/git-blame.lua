return {
    "f-person/git-blame.nvim",
    config = function()
        local gb = require("gitblame")
        gb.setup { enabled = true }

		-- git-blame
		vim.keymap.set("n", "<leader>gbo", "<cmd>GitBlameOpenCommitURL<CR>")
    end
}
