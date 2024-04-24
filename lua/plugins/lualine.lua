-- Filename: lualine.lua
-- Last Change: Sun, 15 Oct 2023 - 10:41

return {
  'nvim-lualine/lualine.nvim',
  -- commit = "146f40d83c6d1f6e1b84d503b92ea0055dfa7f3e",
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = { "BufReadPre", "BufNewFile", "VimEnter" },
  opts = {
    options = {
      -- theme = 'tokyonight',
      theme = 'auto',
      -- component_separators = { left = '', right = '' },
      -- section_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      disabled_filetypes = {
        'mason',
        'dashboard',
        'NeogitStatus',
        'NeogitCommitView',
        'NeogitPopup',
        'NeogitConsole',
        -- 'NvimTree',
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        'diff',
        {
          'diagnostics',
          sources = { 'nvim_lsp', 'nvim_diagnostic' },
        },
        function()
          local ok, m = pcall(require, 'better_escape')
          return ok and m.waiting and '✺' or ''
        end,
      },
      lualine_c = {
        'filename',
        {
          function()
            return require('nvim-navic').get_location()
          end,
          cond = function()
            return require('nvim-navic').is_available()
          end,
        },
      },
      lualine_x = { 'fileformat', 'filetype' },
      lualine_y = { 'progress', 'selectioncount' },
      lualine_z = { 'location' },
    },
    extensions = {
      'man',
      'toggleterm',
      'neo-tree',
      'symbols-outline',
      'trouble',
      'lazy',
    },
  },
}
