local lozerdGroup = vim.api.nvim_create_augroup("lozerd", { clear = true })

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

-- Go to the last cursor position when reopening buffer
-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	group = lozerdGroup,
-- 	desc = "Restore last cursor position",
-- 	callback = function()
-- 		vim.defer_fn(function()
-- 			if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
-- 				vim.cmd('normal! g`"')
-- 			end
-- 		end, 0)
-- 	end,
-- })
