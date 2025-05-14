return {
	"williamboman/mason.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
        "williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")

		mason.setup()
		require("mason-tool-installer").setup({
			ensure_installed = { "stylua", "lua_ls", "pylsp", "basedpyright", "ts_ls", "cssls" },
			automatic_installation = true,
		})

		local function mason_package_path(package)
			local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
			return path
		end

		-- depends on package manager / language
        local command = "/venv/bin/pip"
		local args = { "install", "pylsp-rope" }
		local cwd = mason_package_path("python-lsp-server")

		require("plenary.job")
			:new({
				command = cwd .. command,
				args = args,
				cwd = cwd,
			})
			:start()
	end,
}
