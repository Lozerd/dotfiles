return {
	"j-hui/fidget.nvim",
	opts = {
		progress = { suppress_on_insert = true, display = { done_ttl = 2 } },
		notification = {
			override_vim_notify = true, -- Redirect vim.notify to fidget
		},
	},
}
