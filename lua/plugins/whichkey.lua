-- File: ~/.config/nvim/lua/plugins/whichkey.lua
-- Last Change: Tue, Jan 2024/01/23 - 12:32:07

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  enabled = true,
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    plugins = {
      marks = false,
      registers = false,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = true,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },

    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = 'Comments' },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      ['<space>'] = 'SPC',
      ['<cr>'] = 'RET',
      ['<tab>'] = 'TAB',
    },
    motions = {
      count = false,
    },
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '->', -- symbol used between a key and it's label
      group = '+', -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
      border = 'none', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      zindex = 1000, -- positive value to position WhichKey above other floating windows.
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = {
      '<silent>',
      '<cmd>',
      '<Cmd>',
      '<CR>',
      '^:',
      '^ ',
      '^call ',
      '^lua ',
      '1v',
    }, -- hide mapping boilerplate
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    triggers = 'auto', -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specifiy a list manually
    -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
    triggers_nowait = {
      -- marks
      '`',
      "'",
      'g`',
      "g'",
      -- registers
      '"',
      '<c-r>',
      -- spelling
      'z=',
    },
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for keymaps that start with a native binding
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by default for Telescope
    disable = {
      buftypes = {},
      filetypes = { 'TelescopePrompt' },
    },
    defaults = {
      mode = { 'n', 'v' },
      ['g'] = { name = '+goto' },
      ['gs'] = { name = '+surround' },
      [']'] = { name = '+next' },
      ['['] = { name = '+prev' },
      -- ["<leader><tab>"] = { name = "+tabs" },
      ['<leader>b'] = { name = '+buffer' },
      ['<leader>c'] = { name = '+code' },
      ['<leader>f'] = { name = '+file/find' },
      ['<leader>g'] = { name = '+git' },
      ['<leader>l'] = { name = '+Lazy' },
      ['<leader>n'] = { name = '+Neovim' },
      ['<leader>z'] = { name = '+Zsh' },
      ['<leader>u'] = { name = '+ui' },
      ['<leader>h'] = { name = '+Harpoon' },
      -- ["<leader>s"] = { name = "+Select" },
      ['<leader>t'] = { name = '+Toggle' },
      -- ["<leader>gh"] = { name = "+hunks" },
      -- ["<leader>q"] = { name = "+quit/session" },
      -- ["<leader>w"] = { name = "+windows" },
      -- ["<leader>x"] = { name = "+diagnostics/quickfix" },
    },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
