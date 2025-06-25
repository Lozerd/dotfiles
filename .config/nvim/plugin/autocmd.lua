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
