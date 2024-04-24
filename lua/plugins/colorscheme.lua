-- File: ~/.config/nvim/lua/plugins/colorscheme.lua
-- Last Change: Thu, Jan 2024/01/11 - 13:52:35

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    -- event = 'VeryLazy'
    priority = 1000,
    opts = {
      transparent = true,
      dim_inactive = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
        light_style = "day",
        style = "moon",
        comments = { italic = false },
        keywords = { italic = false },
      },
    },
  },

  {
    "Yazeed1s/oh-lucy.nvim",
    event = "VeryLazy",
  },

  {
    "pauchiner/pastelnight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {

        --- Style to be applied to different syntax groups.
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},

        --- Background styles. Can be 'dark', 'transparent' or 'normal'.
        sidebars = "dark",
        floats = "dark",
      },
    },
  },

  {
    "aktersnurra/no-clown-fiesta.nvim",
    event = "VeryLazy",
  },

  {
    "ricardoraposo/gruvbox-minor.nvim",
    -- event = 'VeryLazy'
    lazy = false,
  },

  -- {
  --   'kaiuri/nvim-juliana',
  --   -- lazy = false,
  --   event ="VeryLazy",
  --   opts = { --[=[ configuration --]=] },
  --   config = true,
  -- },

  -- {
  --   "LunarVim/primer.nvim",
  --   lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   -- commit = "b8d7e08eed9a61eb2f49b9196b01f7f2932735ff",
  -- },

  -- {
  --   'rebelot/kanagawa.nvim', -- You can replace this with your favorite colorscheme
  --   lazy = false, -- We want the colorscheme to load immediately when starting Neovim
  --   -- event = "VeryLazy",
  --   priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
  --   opts = {
  --     commentStyle = { italic = false },
  --     keywordStyle = { italic = false },
  --
  --     -- Replace this with your scheme-specific settings or remove to use the
  --     -- defaults
  --
  --     -- transparent = true,
  --     background = {
  --       -- light = "lotus",
  --       dark = "wave", -- "wave, dragon"
  --     },
  --     colors = {
  --       palette = {
  --         -- Background colors
  --         sumiInk0 = "#161616", -- modified
  --         sumiInk1 = "#181818", -- modified
  --         sumiInk2 = "#1a1a1a", -- modified
  --         sumiInk3 = "#1F1F1F", -- modified
  --         sumiInk4 = "#2A2A2A", -- modified
  --         sumiInk5 = "#363636", -- modified
  --         sumiInk6 = "#545454", -- modified
  --
  --         -- Popup and Floats
  --         waveBlue1 = "#322C47", -- modified
  --         waveBlue2 = "#4c4464", -- modified
  --
  --         -- Diff and Git
  --         winterGreen = "#2B3328",
  --         winterYellow = "#49443C",
  --         winterRed = "#43242B",
  --         winterBlue = "#252535",
  --         autumnGreen = "#76A56A", -- modified
  --         autumnRed = "#C34043",
  --         autumnYellow = "#DCA561",
  --
  --         -- Diag
  --         samuraiRed = "#E82424",
  --         roninYellow = "#FF9E3B",
  --         waveAqua1 = "#7E9CD8", -- modified
  --         dragonBlue = "#7FB4CA", -- modified
  --
  --         -- Foreground and Comments
  --         oldWhite = "#C8C093",
  --         fujiWhite = "#F9E7C0", -- modified
  --         fujiGray = "#727169",
  --         oniViolet = "#BFA3E6", -- modified
  --         oniViolet2 = "#BCACDB", -- modified
  --         crystalBlue = "#8CABFF", -- modified
  --         springViolet1 = "#938AA9",
  --         springViolet2 = "#9CABCA",
  --         springBlue = "#7FC4EF", -- modified
  --         waveAqua2 = "#77BBDD", -- modified
  --
  --         springGreen = "#98BB6C",
  --         boatYellow1 = "#938056",
  --         boatYellow2 = "#C0A36E",
  --         carpYellow = "#FFEE99", -- modified
  --
  --         sakuraPink = "#D27E99",
  --         waveRed = "#E46876",
  --         peachRed = "#FF5D62",
  --         surimiOrange = "#FFAA44", -- modified
  --         katanaGray = "#717C7C",
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require('kanagawa').setup(opts) -- Replace this with your favorite colorscheme
  --     vim.cmd("colorscheme kanagawa") -- Replace this with your favorite colorscheme
  --
  --     -- Custom diff colors
  --     vim.cmd([[
  --     autocmd VimEnter * hi DiffAdd guifg=#00FF00 guibg=#005500
  --     autocmd VimEnter * hi DiffDelete guifg=#FF0000 guibg=#550000
  --     autocmd VimEnter * hi DiffChange guifg=#CCCCCC guibg=#555555
  --     autocmd VimEnter * hi DiffText guifg=#00FF00 guibg=#005500
  --     ]])
  --
  --     -- Custom border colors
  --     vim.cmd([[
  --     autocmd ColorScheme * hi NormalFloat guifg=#F9E7C0 guibg=#1F1F1F
  --     autocmd ColorScheme * hi FloatBorder guifg=#F9E7C0 guibg=#1F1F1F
  --     ]])
  --   end
  -- },

  {
    "Shatur/neovim-ayu",
    event = "VeryLazy",
    config = function()
      -- disable italic comments
      local colors = require("ayu.colors")
      colors.generate() -- Pass `true` to enable mirage

      require("ayu").setup({
        overrides = function()
          return { Comment = { fg = colors.comment } }
        end,
      })
    end,
  },

  {
    "marko-cerovac/material.nvim",
    event = "VeryLazy",
  },

  {
    "ellisonleao/gruvbox.nvim",
    event = "VeryLazy",
    -- lazy = true,
    priority = 1000,
    opts = {
      colorscheme = "gruvbox",
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      dim_inactive = true,
    },
  },

  {
    "myypo/borrowed.nvim",
    lazy = false,
    priority = 1000,

    version = "^0", -- Optional: avoid upgrading to breaking versions

    config = function()
      -- require("borrowed").setup({ ... }) -- Optional: only has to be called to change settings

      -- If you are changing the config, colorscheme command has to be called after setup()
      -- vim.cmd("colorscheme mayu") -- OR vim.cmd("colorscheme shin")
    end,
  },

  {
    "oxfist/night-owl.nvim",
    event = "VeryLazy",
    -- lazy = true,     -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },

  {
    "navarasu/onedark.nvim",
    event = "VeryLazy",
  },

  {
    "mhartington/oceanic-next",
    event = "VeryLazy",
  },

  {
    "shaunsingh/nord.nvim",
    event = "VeryLazy",
  },

  {
    "tanvirtin/monokai.nvim",
    event = "VeryLazy",
  },

  {
    "ofirgall/ofirkai.nvim",
    event = "VeryLazy",
  },

  {
    "Mofiqul/dracula.nvim",
    event = "VeryLazy",
    opts = {
      italic_comment = false,
    },
  },

  {
    "rose-pine/neovim",
    event = "VeryLazy",
    name = "rose-pine",
    opts = {
      dim_inactive_windows = true,
      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },
    },
  },

  {
    "EdenEast/nightfox.nvim",
    -- event = "VeryLazy",
    lazy = false,
    opts = {
      options = {
        dim_inactive = true,
        styles = {
          comments = "NONE",
          keywords = "bold",
          types = "bold",
        },
      },
    },
  },

  {
    "catppuccin/nvim",
    event = "VeryLazy",
    name = "catppuccin",
    priority = 800,
    opts = {
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = true,
    },
  },
}
