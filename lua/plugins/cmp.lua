-- File: ~/.config/nvim/lua/plugins/cmp.lua
-- Last Change: Mon, Jan 2024/01/29 - 12:29:27

local M = {
  'hrsh7th/nvim-cmp',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'L3MON4D3/LuaSnip', event = 'InsertEnter' },
    { 'hrsh7th/cmp-nvim-lua' },
  },
  event = {
    'InsertEnter',
    --'BufRead',
    --'BufNewFile',
    --'WinEnter',
  },
}

function M.config()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  -- require("luasnip/loaders/from_vscode").lazy_load()
  -- require("luasnip/loaders/from_snipmate").load({ paths = vim.fn.stdpath("config") .. "/snippets/" })
  -- require("luasnip/loaders/from_lua").load({ paths = "~/.config/nvim/luasnip/" })
  require('luasnip/loaders/from_lua').load({ paths = vim.fn.stdpath('config') .. '/luasnip/' })
  -- require("luasnip.loaders.from_lua").load({ paths =  vim.fn.stdpath("config") .. "/luasnip/"  })

  luasnip.config.setup({
    history = false, -- do not keep around last snippet local to jump back
    update_events = { 'TextChanged', 'TextChangedI' },
    enable_autosnippets = true,
    store_selection_keys = '<Tab>',
    -- region_check_events = 'InsertEnter',
    region_check_events = 'CursorHold,InsertLeave',
    -- delete_check_events = 'InsertLeave'
    delete_check_events = 'TextChanged,InsertEnter',
  })

  local check_backspace = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
  end

  local kind_icons = {
    Array = ' ',
    Boolean = '󰨙 ',
    Class = ' ',
    Codeium = '󰘦 ',
    Color = ' ',
    Control = ' ',
    Collapsed = ' ',
    Constant = '󰏿 ',
    Constructor = ' ',
    Copilot = ' ',
    Enum = ' ',
    EnumMember = ' ',
    Event = ' ',
    Field = ' ',
    File = ' ',
    Folder = ' ',
    Function = '󰊕 ',
    Interface = ' ',
    Key = ' ',
    Keyword = ' ',
    Method = '󰊕 ',
    Module = ' ',
    Namespace = '󰦮 ',
    Null = ' ',
    Number = '󰎠 ',
    Object = ' ',
    Operator = ' ',
    Package = ' ',
    Property = ' ',
    Reference = ' ',
    Snippet = ' ',
    String = ' ',
    Struct = '󰆼 ',
    TabNine = '󰏚 ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = ' ',
    Value = ' ',
    Variable = '󰀫 ',
  }

  -- create a treshhold for big files
  local preferred_sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
  }

  local function tooBig(bufnr)
    local max_filesize = 10 * 1024 -- 100 KB
    local check_stats = (vim.uv or vim.loop).fs_stat
    local ok, stats = pcall(check_stats, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size > max_filesize then
      return true
    else
      return false
    end
  end
  vim.api.nvim_create_autocmd('BufRead', {
    group = vim.api.nvim_create_augroup('CmpBufferDisableGrp', { clear = true }),
    callback = function(ev)
      local sources = preferred_sources
      if not tooBig(ev.buf) then
        sources[#sources + 1] = { name = 'buffer', keyword_length = 3 }
      end
      cmp.setup.buffer({
        sources = cmp.config.sources(sources),
      })
    end,
  }) -- create a treshhold for big files (end)

  cmp.setup({
    view = {
      entries = {
        name = 'custom',
        selection_order = 'near_cursor',
        follow_cursor = true,
      },
    },
    performance = {
      max_view_entries = 7,
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    check_ts = true,
    mapping = cmp.mapping.preset.insert({
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      -- ['<CR>'] = cmp.mapping.confirm { select = true },
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),

      ['<C-l'] = cmp.mapping(function()
        if ls.coice_active() then
          ls.change_choice(1)
        end
      end, { 'i', 's' }),

      ['<C-h'] = cmp.mapping(function()
        if ls.coice_active() then
          ls.change_choice(-1)
        end
      end, { 'i', 's' }),

      ['<C-f>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<C-b>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
    }),
    formatting = {
      format = function(entry, vim_item)
        -- Kind icons
        -- This concatonates the icons with the name of the item kind
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
        vim_item.menu = ({ -- Source
          luasnip = '[LuaSnip]',
          buffer = '[Buffer]',
          nvim_lsp = '[LSP]',
          nvim_lua = '[Lua]',
          latex_symbols = '[LaTeX]',
        })[entry.source.name]
        return vim_item
      end,
    },

    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find('^_+')
          local _, entry2_under = entry2.completion_item.label:find('^_+')
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
      },
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lua' },
      { name = 'cmdline' },
      { name = 'buffer' },
      { name = 'path' },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = true,
    },
    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    }),

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' },
          },
        },
      }),
    }),
  })
end

return M
