vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf, remap = false }
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
		local ks = vim.keymap.set

		vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        -- stylua: ignore start
        ks("n", "gd", function() vim.lsp.buf.definition() end, opts)
        ks("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        ks("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
        ks("n", "<leader>vws", function(s) vim.lsp.buf.workspace_symbol(s) end, opts)
        ks("n", "<leader>vd", function() vim.diagnostic.open_float{ source = false } end, opts)
        ks("n", "[d", function() vim.diagnostic.jump({ count = 1, float = { border = "rounded" } }) end, opts)
        ks("n", "]d", function() vim.diagnostic.jump({ count = -1, float = { border = "rounded" } }) end, opts)
        ks("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        ks("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        ks("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        ks({ "n", "v" }, "<leader>r", function() vim.lsp.buf.rename() end, opts)
		-- stylua: ignore end
		ks("n", "<M-CR>", function()
			vim.lsp.buf.code_action({ context = { only = { "quickfix" } } })
		end, opts)
		ks("n", "<C-A-O>", function()
			local filter = function(action)
				return action.kind == "source.organizeImports"
			end
			vim.lsp.buf.code_action({ filter = filter, apply = true })
		end, opts)

		-- disable ugly lsp syntax
		if client.name == "basedpyright" then
			client.server_capabilities.semanticTokensProvider = nil
		end

		if client.name == "pylsp" and vim.fn.executable("basedpyright") ~= 0 then
			client.server_capabilities.hoverProvider = nil
		end
	end,
})

if vim.fn.has("nvim-0.10") == 0 then
	local signs = { Error = " ", Warn = " ", Hint = "󰌶", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end

local severity = vim.diagnostic.severity

vim.diagnostic.config({
	underline = true,
	virtual_text = { spacing = 4, prefix = "●" },
	-- virtual_text = { spacing = 4, prefix = "\u{ea71}" },
	update_in_insert = true,
	float = { source = false },
	severity_sort = true,
	signs = {
		[severity.ERROR] = " ",
		[severity.WARN] = " ",
		[severity.HINT] = "󰌶",
		[severity.INFO] = " ",
	},
})

vim.lsp.enable({
    -- "basedpyright",
    "pyrefly",
	"pylsp",
	"lua_ls",
	"ts_ls",
	"djlsp",
	"golsp",
    "zls",
	"clangd",
	"ruff",
    "qmlls",
})
