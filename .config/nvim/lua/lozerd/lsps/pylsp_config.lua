return {
    cmd = { "pylsp", "-v", "--log-file", "/tmp/nvim-pylsp.log" },
    settings = {
        pylsp = {
            plugins = {
                autopep8 = { enabled = true, maxLineLength = 120 },
                -- autopep8 = disabled,
                flake8 = {
                    enabled = true,
                    config = tox_config_dir(),
                    maxLineLength = 120,
                    maxComplexity = 15
                },
                jedi = disabled,
                jedi_completion = disabled,
                jedi_definition = disabled,
                jedi_hover = disabled,
                jedi_references = disabled,
                jedi_signature_help = disabled,
                jedi_symbols = disabled,
                mccabe = disabled,
                preload = disabled,
                pycodestyle = { enabled = false, maxLineLength = 120 },
                -- pycodestyle = disabled,
                pydocstyle = {
                    enabled = true,
                    ignore = {
                        "D100", "D101", "D102", "D105", "D106", "D107",
                        "D203", "D210", "D212", "D205"
                    }
                },
                pyflakes = disabled,
                pylint = disabled,
                rope_autoimport = disabled,
                rope_completion = disabled,
                yapf = disabled,
                black = disabled,
                rope = { ropeFolder = ".ropeproject" },
            },
        },
    },
}
