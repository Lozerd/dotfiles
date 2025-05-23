local rg_opts = table.concat({
	"--column",
	"--line-number",
	"--no-heading",
	"--color=always",
	"--smart-case",
	"--max-columns=4096",
	"--glob",
	"!*.min.js",
	"-e",
}, " ")

return {
	"ibhagwan/fzf-lua",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "junegunn/fzf", build = "./install --bin" },
	},
	opts = {
		previewers = { bat = { cmd = "batcat" } },
		keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } },
		colorschemes = { preview = "onedark" },
		grep = { rg_opts = rg_opts },
	},
	config = function(_, opts)
		local fzf = require("fzf-lua")
		local defaults = require("fzf-lua.defaults").defaults
		local fd_opts = defaults.files.fd_opts .. " --exclude '*.min.js'"

		local opts = vim.tbl_deep_extend("force", opts, { files = { fd_opts = fd_opts } })
		fzf.setup(opts)

		vim.keymap.set("n", "<leader><C-e>", fzf.oldfiles, { desc = "[C-e] View recent files" })
		vim.keymap.set("n", "<leader><space>", fzf.buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set("n", "<leader>/", fzf.lgrep_curbuf, { desc = "[/] Fuzzily search in current buffer" })
		vim.keymap.set("n", "<leader>pf", function()
			fzf.files({ hidden = true })
		end, { desc = "[P]roject [F]iles" })

		vim.keymap.set("n", "<leader>ht", fzf.helptags, { desc = "Neovim [H]elp[T]ags" })

		vim.keymap.set("n", "<leader>ps", fzf.live_grep_resume, { desc = "[P]roject [S]trings" })

        -- Git related staff
        vim.keymap.set("n", "<leader>gt", fzf.git_tags, { desc = "[G]it [T]ags" })
        vim.keymap.set("n", "<leader>gz", fzf.git_stash, { desc = "[G]it [S]tash" })
        vim.keymap.set("n", "<leader>gf", fzf.git_files, { desc = "[G]it [F]iles" })
        vim.keymap.set("n", "<leader>gc", fzf.git_commits, { desc = "[G]it [C]ommits" })
        vim.keymap.set("n", "<leader>gbr", fzf.git_branches, { desc = "[G]it [B][R]anches" })
    end
}
