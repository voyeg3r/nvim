-- Filename: ~/.config/nvim/lua/plugins/telescope.lua
-- Last Change: Wed, 25 Oct 2023 - 07:35

local mapfile = '  '

-- local function filenameFirst(_, path)
--   local tail = vim.fs.basename(path)
--   local parent = vim.fs.dirname(path)
--   local home_dir = vim.fn.expand("~")
--   if parent:sub(1, #home_dir) == home_dir then
--     parent = "~/" .. parent:sub(#home_dir + 2)
--   end
--   if parent == "." then
--     return tail
--   else
--     return string.format("%s\t\t%s", tail, parent)
--   end
-- end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'TelescopeResults',
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd('TelescopeParent', '\t\t.*$')
      vim.api.nvim_set_hl(0, 'TelescopeParent', { link = 'Comment' })
    end)
  end,
})

return {
  'nvim-telescope/telescope.nvim',
  -- commit = "40c31fdde93bcd85aeb3447bb3e2a3208395a868",
  event = 'Bufenter',
  cmd = { 'Telescope' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      -- commit = "6c921ca12321edaa773e324ef64ea301a1d0da62",
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
    {
      'debugloop/telescope-undo.nvim',
      config = function()
        require('telescope').load_extension('undo')
      end,
    },
  },
  -- branch = "0.1.x",
  keys = {
    {
      '<leader>ff',
      function()
        return require('telescope.builtin').find_files()
      end,
      desc = mapfile .. 'Find files',
    },
    {
      '<leader>fw',
      function()
        return require('telescope.builtin').live_grep()
      end,
      desc = mapfile .. 'Find words',
    },
    {
      '<leader>fb',
      function()
        return require('telescope.builtin').buffers()
      end,
      desc = mapfile .. 'Search buffers',
    },
    {
      '<leader>fh',
      function()
        return require('telescope.builtin').help_tags()
      end,
      desc = mapfile .. 'Search help',
    },
    {
      '<leader>fm',
      function()
        return require('telescope.builtin').man_pages()
      end,
      desc = mapfile .. 'Search man pages',
    },
    {
      '<leader>fr',
      function()
        return require('telescope.builtin').oldfiles()
      end,
      desc = mapfile .. 'Search recently opened files',
    },
    {
      '<leader>fR',
      function()
        return require('telescope.builtin').registers()
      end,
      desc = mapfile .. 'Search registers',
    },
    {
      '<leader>fk',
      function()
        return require('telescope.builtin').keymaps()
      end,
      desc = mapfile .. 'Search keymaps',
    },
    {
      '<leader>fc',
      function()
        return require('telescope.builtin').commands()
      end,
      desc = mapfile .. 'Search commands',
    },
    {
      '<leader>ft',
      '<cmd>TodoTelescope<CR>',
      desc = mapfile .. 'Search through todo comments',
    },
    {
      '<leader>Gs',
      function()
        return require('telescope.builtin').git_status()
      end,
      desc = mapfile .. 'Seach through changed files',
    },
    {
      '<leader>Gb',
      function()
        return require('telescope.builtin').git_branches()
      end,
      desc = mapfile .. 'Search through git branches',
    },
    {
      '<leader>Gc',
      function()
        return require('telescope.builtin').git_commits()
      end,
      desc = mapfile .. 'Search and checkout git commits',
    },
    {
      '<leader>U',
      function()
        return require('telescope').extensions.undo.undo()
      end,
      desc = mapfile .. 'Search through undo tree',
    },
  },
  opts = {
    defaults = {
      theme = 'tokyonight',
      -- path_display = { 'smart' },
      -- path_display = filenameFirst,
      path_display = {
        filename_first = {
          reverse_directories = false,
        },
      },
      file_ignore_patterns = { '.git/', 'node_modules' },
      layout_strategy = 'vertical',
      layout_config = { prompt_position = 'top' },
      sorting_strategy = 'ascending',
      mappings = {
        i = {
          ['<Esc>'] = 'close',
          ['<C-c>'] = false,
        },
      },
      layout_config = {
        horizontal = {
          preview_cutoff = 0,
        },
      },
    },
    pickers = {
      colorscheme = { enable_preview = true },
      find_files = {
        find_command = {
          'rg',
          '--color=never',
          '--files',
          '--hidden',
          '--glob',
          '!**/.git/*',
        },
      },
    },
    extensions = {
      undo = {
        side_by_side = true,
        layout_strategy = 'vertical',
      },
    },
  },
}
