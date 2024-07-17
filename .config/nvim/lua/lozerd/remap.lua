local keymap = vim.keymap
vim.g.mapleader = " "
vim.g.ranger_map_keys = 0
vim.g.ranger_replace_netrw = 1

-- keymap.set("n", "<leader>pv", vim.cmd.Ex)
keymap.set("n", "<leader>pv", [[ :Ranger<CR> ]])

-- New Tab
keymap.set("n", "te", ":tabedit<Return>", { silent = true })

-- Split window horizontally
keymap.set("n", "ss", ":split<Return><C-w>w", { silent = true })

-- Split window vertically
keymap.set("n", "sv", ":vsplit<Return><C-w>w", { silent = true })

-- Resize pane
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

keymap.set("n", "<A-Left>", ":tabprevious<Return>", { silent = true })
keymap.set("n", "<A-Right>", ":tabnext<Return>", { silent = true })

keymap.set("", "sh", "<C-w>h")
keymap.set("", "sk", "<C-w>k")
keymap.set("", "sj", "<C-w>j")
keymap.set("", "sl", "<C-w>l")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "n", "nzzzv")

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>/gI<Left><Left><Left>]])

keymap.set("x", "<leader>p", [["_dP]])

keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set("n", "Q", "<nop>")
-- keymap.set("n", "<leader>f", function()
--     vim.lsp.buf.format({
--         timeout_ms = 2000,
--         async = true
--     })
-- end)

-- Define a keymap for range formatting
-- vim.keymap.set('v', '<leader>f', function()
--     local start_pos = vim.fn.getpos("'<")
--     local end_pos = vim.fn.getpos("'>")
-- 
--     local start_line = start_pos[2] - 1
--     local end_line = end_pos[2]
-- 
--     local params = {
--         textDocument = vim.lsp.util.make_text_document_params(),
--         range = {
--             start = { line = start_line, character = 0 },
--             ["end"] = { line = end_line, character = 0 },
--         },
--     }
-- 
--     vim.lsp.buf_request(0, 'textDocument/rangeFormatting', params, function(err, result, ctx, config)
--         if err then
--             vim.notify("Error formatting: " .. err.message, vim.log.levels.ERROR)
--         end
--         if not result then return end
--         vim.lsp.util.apply_text_edits(result, 0, "utf-16")
--     end)
-- end, { noremap = true, silent = true, desc = 'Format selected lines using gopls' })
