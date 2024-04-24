-- File: ~/.config/nvim/lua/plugins/gitsigns.lua
-- Last Change: Tue, Feb 2024/02/13 - 15:02:23

return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c',
          function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end,
          {
            expr = true,
            desc = 'Next hunk'
          }
        )


        map('n', '[c',
          function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end,
          {
            expr = true,
          }
        )

        -- Actions
        map(
          'n',
          '<leader>hs',
          gs.stage_hunk,
          {
            desc = 'Stage hunk',
          }
        )

        map(
          'n',
          '<leader>hr',
          gs.reset_hunk,
          {
            desc = 'Reset hunk',
          }
        )

        map(
          'v',
          '<leader>hs',
          function()
            gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
          end,
          {
            desc = 'stage hunk (visual)'
          }
        )

        map(
          'v',
          '<leader>hr',
          function()
            gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
          end,
          {
            desc = 'reset hunk (visual)'
          }
        )

        map(
          'n',
          '<leader>hS',
          gs.stage_buffer,
          {
            desc = 'Stage buffer',
          }
        )

        map(
          'n',
          '<leader>hu',
          gs.undo_stage_hunk,
          {
            desc = 'undo stage hunk'
          }
        )

        map(
          'n',
          '<leader>hR',
          gs.reset_buffer,
          {
            desc = 'reset buffer'
          }
        )

        map(
          'n',
          '<leader>hp',
          gs.preview_hunk,
          {
            desc = 'Preview hunk'
          }
        )

        map(
          'n',
          '<leader>hb',
          function() gs.blame_line { full = true } end,
          {
            desc = 'blame line'
          }
        )

        map(
          'n',
          '<leader>tb',
          gs.toggle_current_line_blame
        )

        map(
          'n',
          '<leader>hd',
          gs.diffthis,
          {
            desc = 'diffthis'
          }
        )

        map(
          'n',
          '<leader>hD',
          function() gs.diffthis('~') end
        )

        map(
          'n',
          '<leader>td',
          gs.toggle_deleted
        )

        -- Text object
        map(
          { 'o', 'x' },
          'ih',
          ':<C-U>Gitsigns select_hunk<CR>',
          {
            desc = 'hunk text-object'
          }
        )

      end
    }
  end
}
