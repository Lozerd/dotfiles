return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
        local dap, dapui, fzf = require("dap"), require("dapui"), require("fzf-lua")

        dapui.setup({
            layouts = {
                {
                    elements = {
                        {
                            id = "repl",
                            size = 1
                        },
                    },
                    position = "bottom",
                    size = 10
                },
                {
                    id = "dapuiFunctional",
                    elements = {
                        {
                            id = "watches",
                            size = 0.35
                        },
                        {
                            id = "scopes",
                            size = 0.5
                        },
                        {
                            id = "stacks",
                            size = 0.15
                        },
                    },
                    position = "bottom",
                    size = 10
                }
            },
        })

        ------------------------
        -- Dap configurations --
        ------------------------

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({ layout = 2 })
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

        -- function key maps differently on different keyboards
        -- <F1> throught <F12> maps normally
        -- <S-F1> through <S-F12> maps to <F13> through <F24>
        -- <C-F1> through <C-F12> maps to <F25> through <F36>
        -- <C-A-F1> through <C-A-F12> maps to <F49> through <F60>

        vim.keymap.set("n", "<F9>", dap.continue)
        vim.keymap.set("n", "<S-F9>", dap.restart)
        vim.keymap.set("n", "<F21>", dap.restart)
        vim.keymap.set("n", "<C-F2>", dap.terminate)
        vim.keymap.set("n", "<F26>", dap.terminate)
        vim.keymap.set("n", "<F8>", dap.step_over)
        vim.keymap.set("n", "<F7>", dap.step_into)
        vim.keymap.set("n", "<S-F7>", dap.run_to_cursor)
        vim.keymap.set("n", "<F19>", dap.run_to_cursor)
        vim.keymap.set("n", "<S-F8>", dap.step_out)
        vim.keymap.set("n", "<F20>", dap.step_out)
        vim.keymap.set("n", "<C-F8>", dap.toggle_breakpoint)
        vim.keymap.set("n", "<F32>", dap.toggle_breakpoint)
        vim.keymap.set("n", "<C-S-F8>", function()
            return fzf.dap_breakpoints()
        end)
        vim.keymap.set({ "n", "v" }, "<A-F8>", dapui.eval)
        vim.keymap.set({ "n", "v" }, "<F56>", dapui.eval)
        vim.keymap.set("n", "<leader>dr", function()
            dapui.close()
            return dapui.open({ layout = 1 })
        end)
        vim.keymap.set("n", "<leader>dv", function()
            dapui.close()
            return dapui.open({ layout = 2 })
        end)

        -----------------
        -- Dap widgets --
        -----------------

        vim.keymap.set("n", "<leader>df", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
        end)

        -------------------
        -- Dap adapters  --
        -------------------
        local dpy = require("dap-python")
        dpy.setup("~/.virtualenvs/debugpy/bin/python")



        -- Python
        dap.adapters.python = {
            type = "executable",
            command = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python",
            args = { "-m", "debugpy.adapter" },
        }


        -----------------------
        -- Dap configuration --
        -----------------------

        -- Get DJANGO_SETTINGS_MODULE
        local get_dsm = function()
            local is_projects = vim.trim(vim.fn.system("pwd")):find(os.getenv("HOME") .. "/projects")
            local dsm_path = os.getenv("DJANGO_SETTINGS_MODULE")

            if not is_projects then
                print("Skipping get_dsm, not a projects dir")
                return nil
            end

            if not dsm_path then
                local arguments = "find * -type f -name 'dev.py' -not -path 'env/*'"
                dsm_path = vim.fn.system(arguments)

                if dsm_path == "" then
                    local substituted_arguments, _ = string.gsub(arguments, "dev.py", "settings.py")
                    dsm_path = vim.fn.system(substituted_arguments)
                end

                dsm_path = string.gsub(dsm_path or "", "/", ".")
                return vim.trim("--settings=" .. dsm_path:sub(1, dsm_path:len() - 4))
            end

            return "--settings=" .. dsm_path
        end

        local default_nvim_dap_python_opts = {
            include_configs = true,
            console = 'integratedTerminal',
            pythonPath = vim.fn.getcwd() .. "/env/bin/python",
            justMyCode = false,
        }

        local current_buf_file = function()
            local file = vim.fn.expand("%:t")
            return file:sub(0, #file - 4)
        end

        dap.configurations.python = {
            {
                type = "python",
                request = "launch",
                name = "Django",
                pythonPath = vim.fn.getcwd() .. "/env/bin/python",
                program = vim.fn.getcwd() .. "/manage.py",
                django = true,
                justMyCode = default_nvim_dap_python_opts.justMyCode,
                autoReload = {
                    enabled = true
                },
                args = {
                    "runserver",
                    -- to enable django's autoreload, need to install debugpy
                    -- directly into django's venv
                    "--noreload",
                    get_dsm(),
                }
            },
            {
                type = "python",
                request = "launch",
                name = "FastApi",
                pythonPath = vim.fn.getcwd() .. "/env/bin/python",
                module = "uvicorn",
                justMyCode = default_nvim_dap_python_opts.justMyCode,
                autoReload = {
                    enable = true,
                },
                args = {
                    "app.main:app",
                    -- "--reload"
                }
            },
            {
                type = "python",
                request = "launch",
                name = "Run current buffer FastApi command",
                pythonPath = vim.fn.getcwd() .. "/env/bin/python",
                module = "commands.update_chatgpt_models",
                -- args = function()
                --     local args_string = vim.fn.input("Command: ")
                --     return { "-m", "commands." .. args_string }
                --     -- local file = vim.fn.expand("%:t")
                --     -- return { "-m", "commands." .. file:sub(0, #file - 4) }
                -- end
            },
            {
                type = "python",
                request = "launch",
                name = "Run pytests",
                module = "pytest",
                justMyCode = default_nvim_dap_python_opts.justMyCode,
                pythonPath = default_nvim_dap_python_opts.pythonPath,
                args = function()
                    local args_string = vim.fn.input("Package or module: ")
                    return { "-q", args_string }
                end
            },
            {
                type = 'python',
                request = 'launch',
                name = 'Launch file',
                program = '${file}',
                justMyCode = default_nvim_dap_python_opts.justMyCode,
                console = default_nvim_dap_python_opts.console,
                pythonPath = default_nvim_dap_python_opts.pythonPath,
            },
            {
                type = 'python',
                request = 'launch',
                name = 'Launch file with arguments',
                program = '${file}',
                justMyCode = default_nvim_dap_python_opts.justMyCode,
                args = function()
                    local args_string = vim.fn.input('Arguments: ')
                    return vim.split(args_string, " +")
                end,
                console = default_nvim_dap_python_opts.console,
                pythonPath = default_nvim_dap_python_opts.pythonPath,
            },
            {
                type = 'python',
                request = 'attach',
                name = 'Attach remote',
                justMyCode = default_nvim_dap_python_opts.justMyCode,
                connect = function()
                    local host = vim.fn.input('Host [127.0.0.1]: ')
                    host = host ~= '' and host or '127.0.0.1'
                    local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
                    return { host = host, port = port }
                end,
            },
            {
                type = 'python',
                request = 'launch',
                name = 'Run doctests in file',
                module = 'doctest',
                justMyCode = default_nvim_dap_python_opts.justMyCode,
                args = { "${file}" },
                noDebug = true,
                console = default_nvim_dap_python_opts.console,
                pythonPath = default_nvim_dap_python_opts.pythonPath,
            },
        }

        local dgo = require("dap-go")
        dgo.setup {}
    end
}
