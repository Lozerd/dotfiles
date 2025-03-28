local M = {}

M.disabled = { enabled = false }

--- Called when an LSP client attaches to a buffer.
--- @param client vim.lsp.Client|nil #The LSP client instance
--- @param bufnr integer #The buffer number where the LSP client attached
local function on_attach(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local ks = vim.keymap.set

    ks("n", "gd", function() vim.lsp.buf.definition() end, opts)
    ks("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    ks("n", "K", function() vim.lsp.buf.hover() end, opts)
    ks("n", "<leader>vws", function(s) vim.lsp.buf.workspace_symbol(s) end, opts)
    ks("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    ks("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    ks("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    ks("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    ks("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    ks("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    ks({ "n", "v" }, "<leader>r", function() vim.lsp.buf.rename() end, opts)
    ks(
        "n",
        "<M-CR>",
        function()
            vim.lsp.buf.code_action({ context = { only = { "quickfix" } } })
        end,
        opts
    )
    ks(
        "n",
        "<C-A-O>",
        function()
            local filter = function(action) return action.kind == "source.organizeImports" end
            vim.lsp.buf.code_action({ filter = filter, apply = true })
        end,
        opts
    )

    -- git-blame
    vim.keymap.set("n", "<leader>gbo", "<cmd>GitBlameOpenCommitURL<CR>", { buffer = bufnr, remap = false })
end

--- Define an autocommand to set up LSP-specific settings on attach.
M.define_on_attach_autocmd = function()
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LozerdLspConfig', {}),
        callback = function(ev)
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            on_attach(client, ev.buf)
        end
    })
end

M.define_diagnostics = function()
    local signs = { Error = " ", Warn = " ", Hint = "󰌶", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
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
        -- on_attach = on_attach  -- actual duplication. Already defined in LspAttach
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
