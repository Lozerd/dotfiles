local function set_python_path(path)
	local clients = vim.lsp.get_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = "basedpyright",
	})
	for _, client in ipairs(clients) do
		if client.settings then
			client.settings.python = vim.tbl_deep_extend("force", client.settings.python or {}, { pythonPath = path })
		else
			client.config.settings =
				vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
		end
		client.notify("workspace/didChangeConfiguration", { settings = nil })
	end
end

return {
	cmd = { "basedpyright-langserver", "--stdio", "--max-old-space-size=1000" },
	filetypes = { "python" },
	-- Disable ugly Lsp syntax overriden highlighting
	settings = {
		basedpyright = {
			analysis = {
				useLibraryCodeForTypes = true,
				autoImportCompletions = true,
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "basic",
                extraPaths = {
                    './externals/apps/',
                    './externals/libs/'
                }
			},
			disableLanguageServices = false,
			disableOrganizeImports = false,
			disableTaggedHints = false,
			importStrategy = "fromEnvironment",
			pythonPath = "python",
			-- venvPath = "env"
		},
	},
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
			client:exec_cmd({
				command = "basedpyright.organizeimports",
				arguments = { vim.uri_from_bufnr(bufnr) },
			})
		end, {
			desc = "Organize Imports",
		})

		vim.api.nvim_buf_create_user_command(0, "LspPyrightSetPythonPath", set_python_path, {
			desc = "Reconfigure basedpyright with the provided python path",
			nargs = 1,
			complete = "file",
		})
	end,
}
