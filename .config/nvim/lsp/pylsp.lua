local disabled = { enabled = false }
return {
	cmd = { "pylsp", "-v", "--log-file", "/tmp/nvim-pylsp.log" },
	filetypes = { "python" },
	--- @type lsp.ClientCapabilities
	capabilities = { textDocument = { hover = nil } },
	settings = {
		pylsp = {
			plugins = {
				autopep8 = { enabled = true, maxLineLength = 120 },
				flake8 = {
					enabled = false,
					config = vim.fn.getcwd() .. "/tox.ini",
					maxLineLength = 120,
					maxComplexity = 15,
				},
				jedi = disabled,
				jedi_completion = disabled,
				jedi_definition = disabled,
				jedi_hover = disabled,
				jedi_references = disabled,
				jedi_signature_help = disabled,
				jedi_symbols = disabled,
				mccabe = disabled,
				preload = disabled,
				pycodestyle = { enabled = false, maxLineLength = 120 },
				pydocstyle = {
					enabled = true,
					ignore = {
						"D100",
						"D101",
						"D102",
						"D105",
						"D106",
						"D107",
						"D203",
						"D210",
						"D212",
						"D205",
					},
				},
				pyflakes = disabled,
				pylint = disabled,
				isort = {
					enabled = true,
					config = {
						line_length = 120,
						multi_line_output = 5,
					},
				},
				rope_autoimport = disabled,
				rope_completion = disabled,
				yapf = disabled,
				black = disabled,
				rope = { ropeFolder = ".ropeproject" },
			},
		},
	},
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
	on_attach = function(client)
		client.server_capabilities.renameProvider = false
	end,
}
