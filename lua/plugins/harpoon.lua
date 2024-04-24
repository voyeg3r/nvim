-- File: ~/.config/nvim/lua/plugins/harpoon.lua
-- Last Change: Mon, Jan 2024/01/08 - 02:33:40

local mapfile = ' '

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<Leader>hh',
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = mapfile .. 'Harpoon Menu'
    },

    {
      '<Leader>ha',
      function()
        harpoon:list():append()
        print('Buffer added to harpon list')
      end,
      desc = mapfile .. 'Harpoon Append File'
    },

    {
      '<Leader>hj',
      function()
        harpoon:list():next()
      end,
      desc = mapfile .. 'Harpoon jump next'
    },

    {
      '<Leader>hk',
      function()
        harpoon:list():prev()
      end,
      desc = mapfile .. 'Harpoon jump prev'
    },

    {
      "<leader>1",
      function() require("harpoon"):list():select(1) end,
      desc = mapfile .. "harpoon to file 1",
    },

    {
      "<leader>2",
      function() require("harpoon"):list():select(2) end,
      desc = mapfile .. "harpoon to file 2",
    },

    {
      "<leader>3",
      function() require("harpoon"):list():select(3) end,
      desc = mapfile .. "harpoon to file 3",
    },

    {
      "<leader>4",
      function() require("harpoon"):list():select(4) end,
      desc = mapfile .. "harpoon to file 4",
    },

    {
      "<leader>5",
      function() require("harpoon"):list():select(5) end,
      desc = mapfile .. "harpoon to file 5",
    },

  },
  config = function()
    harpoon = require('harpoon'):setup()
    menu = {
      width = 120
    }
  end,
}
