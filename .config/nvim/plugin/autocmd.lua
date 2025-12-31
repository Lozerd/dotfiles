-- Function to format the selected range
local function format_range(start_line, end_line)
	require("conform").format({
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

-- Enable conceal for markdown and json files only
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "rst", "json", "tex" },
	callback = function()
		vim.opt_local.conceallevel = 2
		vim.opt_local.concealcursor = "" -- show hidden parts when cursor is on them
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.opt.wrap = true
	end,
})
