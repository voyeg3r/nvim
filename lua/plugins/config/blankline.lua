require("indent_blankline").setup {
    char = "▏",
    buftype_exclude = { "nofile", "terminal"},
    filetype_exclude = { "help",
                        "alpha",
                        "packer",
                        "lspinfo",
                        "markdown",
                        "TelescopePrompt",
                        "TelescopeResults",
                    },
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
}
