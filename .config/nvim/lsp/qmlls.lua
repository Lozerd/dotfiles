---@brief
---
--- https://doc.qt.io/qt-6/qtqml-tooling-qmlls.html
---
--- > QML Language Server is a tool shipped with Qt that helps you write code in your favorite (LSP-supporting) editor.
---
--- Source in the [QtDeclarative repository](https://code.qt.io/cgit/qt/qtdeclarative.git/)

---@type vim.lsp.Config
return {
	cmd = { "qmlls" },
	filetypes = { "qml", "qmljs" },
	root_markers = { ".git" },
	init_options = {
		qmlImportPaths = { vim.fn.getcwd() },
	},
	on_init = function(client)
		-- Force qmlls to re-read environment so it sees our imports
		client.notify("qmlls/enableTypeInfo", { enable = true })
	end,
}
