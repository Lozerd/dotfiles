return {
<<<<<<< HEAD
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    enabled = false,
    config = function()
        local copilot = require("copilot");
        copilot.setup({
            suggestion = { auto_trigger = true, debounce = 50, keymap = { accept = false, } },
            filetypes = { python = true, javascript = true },
        })
    end
=======
    { "github/copilot.vim", enabled = false }
>>>>>>> b705eb5 (feat(nvim, hypr, tmux): introduce ghostty, fzf-lua opts)
}
