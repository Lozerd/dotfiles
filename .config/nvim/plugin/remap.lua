local set = vim.keymap.set

local function explorer_with_fallback()
  local ok, err = pcall(vim.cmd, "Oil")
  if not ok then
    vim.cmd("Ex")
    vim.notify("Oil not found, falling back to netrw (:Ex)", vim.log.levels.WARN)
  end
end

set("n", "<leader>pv", explorer_with_fallback, {desc="Navigate file explorer"})
set("n", "<leader>x", "<cmd>.lua<CR>", {desc="Source line"})

-- New Tab
set("n", "te", ":tabedit<Return>", { silent = true })

-- Split window horizontally
set("n", "ss", ":split<Return><C-w>w", { silent = true })

-- Split window vertically
set("n", "sv", ":vsplit<Return><C-w>w", { silent = true })

-- Resize pane
set("n", "<C-w><left>", "<C-w><")
set("n", "<C-w><right>", "<C-w>>")
set("n", "<C-w><up>", "<C-w>+")
set("n", "<C-w><down>", "<C-w>-")

set("n", "<A-Left>", ":tabprevious<Return>", { silent = true })
set("n", "<A-Right>", ":tabnext<Return>", { silent = true })

set("", "sh", "<C-w>h")
set("", "sk", "<C-w>k")
set("", "sj", "<C-w>j")
set("", "sl", "<C-w>l")

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "N", "Nzzzv")
set("n", "n", "nzzzv")

set("n", "<leader>s", [[:%s/\<<C-r><C-w>/gI<Left><Left><Left>]])

set("x", "<leader>p", [["_dP]])

set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])

set("n", "Q", "<nop>")
