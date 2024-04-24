-- File: ~/.config/nvim/lua/plugins/indentline.lua
-- Last Change: Wed, Jan 2024/01/10 - 21:20:45

-- if true then return {} end
-- Show indent lines

return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  enabled = true,
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { enabled = true },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "markdown",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
  main = "ibl",
}
