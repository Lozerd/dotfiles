return {
	"j-hui/fidget.nvim",
	dependencies = { "navarasu/onedark.nvim" },
	config = function(_, opts)
		require("fidget").setup(opts)
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" }) -- onedark sets it
		-- vim.api.nvim_set_hl(0, "FidgetWindow", { bg = "NONE" })
	end,
	opts = {
		progress = { display = { done_ttl = 2 }, suppress_on_insert = true },
		notification = { window = { normal_hl = "FidgetWindow", winblend = 0 } },
	},
}
