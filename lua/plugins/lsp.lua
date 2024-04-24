-- File: ~/.config/nvim/lua/plugins/lsp.lua
-- Last Change: Tue, Jan 2024/01/09 - 01:17:10

local mapfile = ' '

return {
  -- mason.nvim
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    opts = {
      ui = {
        icons = {
          package_installed = '',
          package_pending = '',
          package_uninstalled = '',
        },
      },
    },
  },

  -- nvim-lspconfig
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      {
        'williamboman/mason-lspconfig.nvim',
        opts = {
          ensure_installed = {
            'marksman',
            'pyright',
            'bashls',
          },
        },
      },

      {
        'jay-babu/mason-null-ls.nvim',
        enabled = false,
        opts = {
          ensure_installed = {
            'stylua',
            'markdownlint',
            'luacheck',
          },
        },
      },
    },
    keys = {
      -- {
      --   '<m-8>',
      --   'vim.lsp.diagnostic.show_line_diagnostics()',
      --   desc = "Shoe diagnostic",
      -- },
      {
        'gd',
        function()
          return require('telescope.builtin').lsp_definitions()
        end,
        desc = mapfile .. 'Goto Definition',
      },
      {
        'gr',
        function()
          return require('telescope.builtin').lsp_references()
        end,
        desc = mapfile .. 'References',
      },
      {
        'gD',
        vim.lsp.buf.declaration,
        desc = mapfile .. 'Goto Declaration',
      },
      {
        'gI',
        function()
          return require('telescope.builtin').lsp_implementations()
        end,
        desc = mapfile .. 'Goto Implementation',
      },
      {
        'gy',
        function()
          return require('telescope.builtin').lsp_type_definitions()
        end,
        desc = mapfile .. 'Goto T[y]pe Definition',
      },
      {
        'K',
        vim.lsp.buf.hover,
        desc = mapfile .. 'Hover',
      },
      {
        'gK',
        vim.lsp.buf.signature_help,
        desc = mapfile .. 'Signature Help',
      },
      {
        '<leader>i',
        '<cmd>LspInfo<cr>',
        desc = mapfile .. 'Lsp info',
      },
      {
        '<leader>I',
        '<cmd>LspInstall<cr>',
        desc = mapfile .. 'Lsp install',
      },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local navic = require('nvim-navic')
      local lspconfig = require('lspconfig')
      local inlay_hints =
        { enabled = true }, lspconfig.clangd.setup({
          on_attach = function(client, bufnr)
            navic.attach(client, bufnr)
          end,
          -- Fix clangd offset encoding
          capabilities = { offsetEncoding = { 'utf-16' } },
        })

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.stdpath('config') .. '/lua'] = true,
              },
            },
            telemetry = { enable = false },
          },
        },
      })
      lspconfig.marksman.setup({
        on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
        end,
      })
    end,
  },

  -- null-ls.nvim
  -- https://andrewcourter.substack.com/p/configure-linting-formatting-and
  {
    'nvimtools/none-ls.nvim',
    enabled = false,
    dependencies = {
      'williamboman/mason.nvim',
      'nvim-lua/plenary.nvim',
      'nvimtools/none-ls-extras.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local nls = require('null-ls')
      return {
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.markdownlint,
          nls.builtins.diagnostics.markdownlint,
          nls.builtins.diagnostics.luacheck,
          nls.builtins.formatting.shfmt,
        },
      }
    end,
  },

  -- fidget.nvim
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    -- NOTE: Keep branch option until further notice: https://shorta.link/wkrANvwU
    branch = 'legacy',
    opts = { window = { blend = 0 } },
  },

  -- lsp_lines.nvim
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = 'LspAttach',
    init = function()
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = { highlight_whole_line = false },
      })
    end,
    config = true,
  },

  { 'kosayoda/nvim-lightbulb' },

  -- symbols-outline.nvim
  {
    'simrat39/symbols-outline.nvim',
    keys = {
      {
        '<leader>co',
        '<cmd>SymbolsOutline<CR>',
        desc = mapfile .. 'Open symbols-outline',
      },
    },
    opts = {
      symbols = {
        File = { icon = ' ' },
        Module = { icon = ' ' },
        Namespace = { icon = ' ' },
        Package = { icon = ' ' },
        Class = { icon = ' ' },
        Method = { icon = ' ' },
        Property = { icon = ' ' },
        Field = { icon = ' ' },
        Constructor = { icon = ' ' },
        Enum = { icon = ' ' },
        Interface = { icon = ' ' },
        Function = { icon = ' ' },
        Variable = { icon = ' ' },
        Constant = { icon = ' ' },
        String = { icon = ' ' },
        Number = { icon = ' ' },
        Boolean = { icon = ' ' },
        Array = { icon = ' ' },
        Object = { icon = ' ' },
        Key = { icon = ' ' },
        Null = { icon = ' ' },
        EnumMember = { icon = ' ' },
        Struct = { icon = ' ' },
        Event = { icon = ' ' },
        Operator = { icon = ' ' },
        TypeParameter = { icon = ' ' },
      },
    },
  },

  -- nvim-navic
  {
    'SmiteshP/nvim-navic',
    event = 'LspAttach',
    opts = {
      icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = ' ',
        Interface = ' ',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = ' ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = ' ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
      },
    },
  },

  { 'folke/neodev.nvim', opts = {} },
}
