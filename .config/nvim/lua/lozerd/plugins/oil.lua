return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        columns = {
            "icon",
            "permissions",
        },
        win_options = { signcolumn = "yes", },
        -- Set to true to watch the filesystem for changes and reload oil
        watch_for_changes = true,
        view_options = {
            -- Show files and directories that start with "."
            show_hidden = true,
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
}
