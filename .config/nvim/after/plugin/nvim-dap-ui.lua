local dap, dapui = require("dap"), require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.after.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.after.event_exited["dapui_config"] = function()
    dapui.close()
end

------------------
-- Dap mappings --
------------------
vim.keymap.set("n", "<F9>", dap.continue)
vim.keymap.set("n", "<F8>", dap.step_over)
vim.keymap.set("n", "<F7>", dap.step_into)
vim.keymap.set("n", "<S-F8>", dap.step_out)
vim.keymap.set("n", "<C-F8>", dap.toggle_breakpoint)
vim.keymap.set({ "n", "v" }, "<A-F8>", dapui.eval)

vim.keymap.set("n", "<leader>lp", function()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
vim.keymap.set("n", "<leader>dr", dap.repl.open)
vim.keymap.set({ "n", "v" }, "<leader>dh", function()
    require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<leader>dp", function()
    require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<leader>ds", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
end)

-------------------
-- Dap adapters  --
-------------------
local dpy = require("dap-python")
-- dpy.setup("~/.virtualenvs/debugpy/bin/python")
dpy.setup(vim.fn.getcwd() .. "/env/bin/python")

-- Python
dap.adapters.python = {
    type = "executable",
    --command = function()
    --    local envPath = os.getenv("VIRTUAL_ENV")
    --    local dpyPath = os.getenv("HOME") .. "/virtualenvs/debugpy/bin/python"
    --end,
    -- command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
    --
    command = vim.fn.getcwd() .. "/env/bin/python",
    -- command = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python",
    args = { "-m", "debugpy.adapter" },
}

-----------------------
-- Dap configuration --
-----------------------

-- Get DJANGO_SETTINGS_MODULE
local get_dsm = function()
    local dsm_path = os.getenv("DJANGO_SETTINGS_MODULE")

    if not dsm_path then
        local arguments = "!find * -type f -name 'dev.py' -not -path 'env/*'"
        dsm_path = vim.cmd(arguments)

        if dsm_path == "" then
            local substituted_arguments, _ = string.gsub(arguments, "dev.py", "settings.py")
            dsm_path = vim.cmd(substituted_arguments)
        end

        dsm_path = string.gsub(dsm_path or "", "/", ".")
    end

    return "--settings=" .. dsm_path
end

-- dap.configurations.django = {
--     type = "python",
--     request = "launch",
--     name = "Django debug session",
--     program = function()
--         return vim.fn.getcwd() .. "/manage.py"
--     end,
--     args = {
--         "runserver",
--         -- get_dsm(),
--     }
-- })

table.insert(dap.configurations.python, {
    type = "python",
    request = "launch",
    name = "Django debug session",
    -- program = function()
    --     print(vim.fn.getcwd() .. "/manage.py")
    --     return vim.fn.getcwd() .. "/manage.py"
    -- end,
    -- pythonPath = function()
    --     print(vim.fn.getcwd() .. "/env/bin/python")
    --     return vim.fn.getcwd() .. "/env/bin/python"
    -- end,
    --pythonPath = function()
    --    return os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python"
    --    -- return vim.fn.getcwd() .. "/env/bin/python"
    --end,
    program = function()
        return vim.fn.getcwd() .. "/manage.py"
    end,
    django = true,
    args = {
        "runserver",
        "--noreload",
        -- get_dsm(),
    }
})
