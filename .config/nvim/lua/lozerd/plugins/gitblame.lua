return {
    "f-person/git-blame.nvim",
    config = function()
        local gb = require("gitblame")

        gb.setup {
            enabled = true
        }
    end
}
