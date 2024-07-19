local util = require("lozerd.util")
local configs = require("lozerd.configs")

return {
    cmd = { "pylsp", "-v", "--log-file", "/tmp/nvim-pylsp.log" },
    settings = {
        pylsp = {
            plugins = {
                autopep8 = { enabled = true, maxLineLength = 120 },
                -- autopep8 = disabled,
                flake8 = {
                    enabled = true,
                    config = configs.tox_config_dir(),
                    maxLineLength = 120,
                    maxComplexity = 15
                },
                jedi = util.disabled,
                jedi_completion = util.disabled,
                jedi_definition = util.disabled,
                jedi_hover = util.disabled,
                jedi_references = util.disabled,
                jedi_signature_help = util.disabled,
                jedi_symbols = util.disabled,
                mccabe = util.disabled,
                preload = util.disabled,
                pycodestyle = { enabled = false, maxLineLength = 120 },
                -- pycodestyle = util.disabled,
                pydocstyle = {
                    enabled = true,
                    ignore = {
                        "D100", "D101", "D102", "D105", "D106", "D107",
                        "D203", "D210", "D212", "D205"
                    }
                },
                pyflakes = util.disabled,
                pylint = util.disabled,
                rope_autoimport = util.disabled,
                rope_completion = util.disabled,
                yapf = util.disabled,
                black = util.disabled,
                rope = { ropeFolder = ".ropeproject" },
            },
        },
    },
}
