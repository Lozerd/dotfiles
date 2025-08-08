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
			"<cmd>FormatRange<CR>",
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
			html = { "djlint" },
			htmldjango = { "djlint" },
		},
		formatters = {
			autopep8 = {
				append_args = { "--max-line-length", "120" },
			},
			djlint = {
				append_args = {
					"--blank-line-after-tag",
					"load,extends,include,endif,endfor,endcomment",
					"--blank-line-before-tag",
					"include,if,for,comment",
					"--max-attribute-length",
					"120",
                    "--custom-blocks",
                    "recursetree, endrecursetree",
					"--profile",
					"django",
					"--quiet",
				},
			},
			-- Deprecated/invalid?
			-- flake8 = {
			--     prepend_args = { "--max-line-length", "120" }
			-- }
		},
	},
}
