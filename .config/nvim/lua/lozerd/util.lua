local M = {}

M.disabled = { enabled = false }

function on_attach(bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function(s) vim.lsp.buf.workspace_symbol(s) end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set({ "n", "v" }, "<leader>r", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<M-CR>", function()
        vim.lsp.buf.code_action({ context = { only = { "quickfix" } } })
    end, opts)
    vim.keymap.set("n", "<C-A-O>", function()
        local filter = function(action) return action.kind == "source.organizeImports" end
        vim.lsp.buf.code_action({ filter = filter, apply = true })
    end, opts)

    -- git-blame
    vim.keymap.set("n", "<leader>gbo", "<cmd>GitBlameOpenCommitURL<CR>", opts)
end

M.define_on_attach_autocmd = function()
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LozerdLspConfig', {}),
        callback = function(ev)
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            on_attach(ev.bufnr)
        end
    })
end

M.define_diagnostics = function ()
    local signs = { Error = " ", Warn = " ", Hint = "󰌶", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            update_in_insert = false,
            virtual_text = { spacing = 4, prefix = "\u{ea71}" },
            severity_sort = true
        }
    )

    vim.diagnostic.config({
        virtual_text = {
            prefix = "●"
        },
        update_in_insert = true,
        float = {
            source = "always",
        },
    })
end

M.make_default_client_capabilities = function()
    return require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

local get_default_server_config = function()
    return {
        capabilities = M.make_default_client_capabilities(),
        on_attach = on_attach
    }
end

M.get_server_config = function(server_name)
    local exists, server_config = pcall(require, "lozerd.lsps." .. server_name .. "_config")

    if exists and server_config.capabilities ~= nil then
        server_config.capabilities = M.make_default_client_capabilities()
    end

    if exists and server_config.on_attach == nil then
        server_config.on_attach = on_attach
    end

    return exists and server_config or get_default_server_config()
end

return M
