return {
    "stevearc/dressing.nvim",
    config = function()
        require("dressing").setup({
            select = {
                backend = { "fzf_lua", "fzf", "builtin" },
            }
        })
    end,
}
