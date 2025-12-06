return {
	"obsidian-nvim/obsidian.nvim",
	dependencies = {
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			completions = { blink = { enabled = true } },
		},
	},
	version = "*", -- recommended, use latest release instead of latest commit
	ft = "markdown",
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Vaults/Vault/",
			},
		},
		picker = {
			name = "fzf-lua",
		},
		legacy_commands = false,
		ui = { enable = false },
		callbacks = {
			enter_note = function(_, note)
				vim.keymap.set("n", "<leader>bl", ":Obsidian backlinks<CR>", { buffer = note.bufnr })
				vim.keymap.set("n", "<leader>l", ":Obsidian links<CR>", { buffer = note.bufnr })
				vim.keymap.set("n", "<leader>tc", ":Obsidian toggle_checkbox<CR>", { buffer = note.bufnr })
			end,
		},
	},
}
