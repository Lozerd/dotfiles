return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "n",
			desc = "Format buffer",
		},
		{
			"<leader>f",
			function()
				-- Function to format the selected range
				local function format_range(start_line, end_line)
					conform.format({
						async = true,
						bufnr = vim.api.nvim_get_current_buf(),
						start_line = start_line,
						end_line = end_line,
					})
				end

				-- Create a proper user command with -range support
				vim.api.nvim_create_user_command("FormatRange", function(opts)
					format_range(opts.line1, opts.line2)
				end, { range = true, desc = "Format a range using conform.nvim" })

				vim.api.nvim_set_keymap("v", "<leader>f", "<cmd>FormatRange<CR>", { noremap = true, silent = true })
			end,
			mode = "v",
			desc = "Format buffer (range)",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "autopep8" },
			json = { "jq" },
			sql = { "sqlfmt" },
		},
		formatters = {
			autopep8 = {
				append_args = { "--max-line-length", "120" },
			},
			-- Deprecated/invalid?
			-- flake8 = {
			--     prepend_args = { "--max-line-length", "120" }
			-- }
		},
	},
}
