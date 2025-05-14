return {
	cmd = { "pylsp", "-v", "--log-file", "/tmp/nvim-pylsp.log" },
	filetypes = { "python" },
	settings = {
		pylsp = {
			plugins = {
				autopep8 = { enabled = true, maxLineLength = 120 },
				-- autopep8 = disabled,
				flake8 = {
					enabled = true,
					config = vim.fn.getcwd() .. "/tox.ini",
					maxLineLength = 120,
					maxComplexity = 15,
				},
				jedi = { enabled = false },
				jedi_completion = { enabled = false },
				jedi_definition = { enabled = false },
				jedi_hover = { enabled = false },
				jedi_references = { enabled = false },
				jedi_signature_help = { enabled = false },
				jedi_symbols = { enabled = false },
				mccabe = { enabled = false },
				preload = { enabled = false },
				pycodestyle = { enabled = false, maxLineLength = 120 },
				-- pycodestyle = { enabled = false },
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
				pyflakes = { enabled = false },
				pylint = { enabled = false },
				isort = {
					enabled = true,
					config = {
						line_length = 120,
						multi_line_output = 5,
					},
				},
				rope_autoimport = { enabled = false },
				rope_completion = { enabled = false },
				yapf = { enabled = false },
				black = { enabled = false },
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
