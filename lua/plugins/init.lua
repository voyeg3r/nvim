-- ~/.config/nvim/lua/plugins/init.lua

-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end


--require('impatient') -- at first comment this line

require('packer').startup({
    function(use)
    use('wbthomason/packer.nvim')
    use 'antoinemadec/FixCursorHold.nvim'
    use {'lewis6991/impatient.nvim', rocks = 'mpack'}   -- faster startup
    use 'shaunsingh/doom-vibrant.nvim'
    use {'nathom/filetype.nvim',
        config = function()
            vim.g.did_load_filetypes = 1
        end,
	}

    -- lsp/autocompletion/snippets
    -- lsp plugins
    use 'rafamadriz/friendly-snippets'
    -- use { 'neovim/nvim-lspconfig'}
    use ({ 'neovim/nvim-lspconfig',
    --     opt = true,
    --     after = 'nvim-cmp',
        -- config = function() require'lsp'.setup() end
        -- config = function() require'plugins.config.lspconfig' end
           config = [[require('plugins.config.lspconfig')]]
    })
    use('onsails/lspkind-nvim')
    use {
        'kabouzeid/nvim-lspinstall',
        opt = true,
        event = "VimEnter",
        config = function()
            require('plugins.config.lspinstall')
        end
    }
    -- use {
    -- "folke/which-key.nvim",
    --     config = function()
    --     require("which-key").setup {
    --     -- your configuration comes here
    --     -- or leave it empty to use the default settings
    --     -- refer to the configuration section below
    --     }
    -- end
    -- }

    -- autocompletion

    -- snippets
    -- use('sirver/ultisnips')
    -- use('quangnguyen30192/cmp-nvim-ultisnips')

    use {
        'hrsh7th/nvim-cmp',
        --after = "friendly-snippets",
        config = function()
            require'plugins.config.cmp'
        end
    }
    use {
        'hrsh7th/cmp-nvim-lsp',
        --after = "cmp_luasnip"
    }
    use {
        'hrsh7th/cmp-buffer',
        --after = "cmp-nvim-lsp"
    }
    use {
        "hrsh7th/cmp-path",
        --after = "cmp-buffer",
    }
    use 'hrsh7th/cmp-cmdline'
    require'cmp'.setup.cmdline(':', {
          sources = {
                  { name = 'cmdline' }
                    }
                })

    use {
        'L3MON4D3/LuaSnip',
        -- after = "nvim-cmp",
        wants = "friendly-snippets",
        config = function()
            require'plugins.config.cmp'
        end
    }
    use {
        'saadparwaiz1/cmp_luasnip',
         --after = "LuaSnip"
    }

    -- these plugins are all realted to editor configs
    use {
            'nvim-lualine/lualine.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
            config = function()
                require'lualine'.setup()
            end
        }
    use 'kevinhwang91/nvim-bqf' -- Enhanced quickfix
    -- use {'danilamihailov/beacon.nvim',
    --     config = function()
    --        vim.cmd 'g:beacon_ignore_filetypes = ['fzf']'
    --     end
    -- }
    use {'karb94/neoscroll.nvim',
            --opt = true,
            config = function()
            require('neoscroll').setup({
                mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'}
            })
        end}
    use { -- Show colors in neovim (Red, Green, Blue, etc.)
        'norcalli/nvim-colorizer.lua',
        opt = true,
        cmd = { 'ColorizerToggle' },
        config = function() require'colorizer'.setup() end
    }
    use({ 'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
            config = function()
                require('plugins.config.telescope')
            end
    })
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    -- use {'nvim-telescope/telescope-fzy-native.nvim'}
    --use ({"lukas-reineke/indent-blankline.nvim",
    --    require("indent_blankline").setup {
    --        char = "▏",
    --        buftype_exclude = { "nofile", "terminal"},
    --        filetype_exclude = { "help", "alpha", "packer", "lspinfo", "markdown",
    --                            "TelescopePrompt",
    --                            "TelescopeResults",
    --                        },
    --        show_trailing_blankline_indent = false,
    --        show_first_indent_level = false,
    --    }
    --})
    use({
            "folke/persistence.nvim",
            event = "BufReadPre", -- this will only start session saving when an actual file was opened
            module = "persistence",
            config = function()
                require("persistence").setup()
            end,
        })
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {} end,
        opt = true,
        cmd = {
        'NvimTreeClipboard',
        'NvimTreeClose',
        'NvimTreeFindFile',
        'NvimTreeOpen',
        'NvimTreeRefresh',
        'NvimTreeToggle',
        }
    }
    use {
        'windwp/nvim-autopairs',
        --after = 'nvim-cmp',
        config = [[require('plugins.config.autopairs')]]
    }
    use({
        'tpope/vim-fugitive',
        opt = true,
        cmd = 'Git'
    })
    use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
        end}
    use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } })
    -- }}}

    -- these add in a bit more bling and flair to nvim
    use({ 'nvim-treesitter/nvim-treesitter',
        branch = '0.5-compat',
        run = ':TSUpdate',
    })
    -- popular themes incoming
    use {'folke/tokyonight.nvim',
      -- opt = true,
      config = function()
        vim.g.tokyonight_style = "night"
        vim.g.tokyonight_sidebars = {}
        vim.cmd 'colorscheme tokyonight'
      end
    }
    use('joshdick/onedark.vim')
    use('sickill/vim-monokai')
    use('morhetz/gruvbox')
    use('shaunsingh/nord.nvim')
    use('sainnhe/gruvbox-material')

    -- tabline
    use {'ap/vim-buftabline',
        config = function()
            require('plugins.config.buftabline')
        end
    }

    -- neesh themes
    use('sainnhe/everforest')
    use('relastle/bluewery.vim')
    use('haishanh/night-owl.vim')
    -- }}}
    end,
    -- display packer dialouge in the center in a floating window
    config = {
        display = {
            open_fn = require('packer.util').float,
        },
    },
})


