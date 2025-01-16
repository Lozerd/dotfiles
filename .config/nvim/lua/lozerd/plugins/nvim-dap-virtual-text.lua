return {
    "theHamsta/nvim-dap-virtual-text",
    -- commit = "9578276dfdc5420624699744377ddd74be2d9a19",
    config = function()
        require("nvim-dap-virtual-text").setup {
            -- virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
            virt_text_pos = 'eol',
        }
    end
}
