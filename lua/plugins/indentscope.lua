-- File: ~/.config/nvim/lua/plugins/indentscope.lua
-- Last Change: Tue, Feb 2024/02/06 - 21:28:43

return {
  "echasnovski/mini.indentscope",
  enabled = true,
  version = false, -- wait till new 0.7.0 release to put it back on semver
  event = "VeryLazy",
  opts = {
    -- symbol = "▏",
    symbol = "│",
    options = { try_as_border = true },
    mappings = {
    -- Textobjects
    object_scope = 'ii',
    object_scope_with_border = 'ai',

    -- Motions (jump to respective border line; if not present - body line)
    goto_top = '[i',
    goto_bottom = ']i',
  },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "Trouble",
        "alpha",
        "dashboard",
        "help",
        "lazy",
        "lazyterm",
        "man",
        "markdown",
        "mason",
        "neo-tree",
        "notify",
        "oil",
        "toggleterm",
        "trouble",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}

