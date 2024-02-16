return {
    "lmburns/lf.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    config = function()
        vim.g.lf_netrw = 1
        require("lf").setup({
            winblend = 10,
            direction = "horizontal",
            border = "rounded",
            escape_quit = true,
            default_file_manager = true,
        })
    end
}
