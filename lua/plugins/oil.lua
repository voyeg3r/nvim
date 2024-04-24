-- File: ~/.config/nvim/lua/plugins/oil.lua
-- Last Change: Thu, Feb 2024/02/01 - 21:08:22

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})

return {
  {
    "stevearc/oil.nvim",
    keys = {
      {
        '<leader>e',
        function()
          require("oil").toggle_float()
        end,
        desc = 'Oil file manager',
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        -- Buffer-local options to use for oil buffers
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        delete_to_trash = true,
        trash_command = "trash-put",
        prompt_save_on_select_new_entry = true,
        float = {
          -- Padding around the floating window
          padding = 5,
          max_width = 58,
          max_height = 28,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          override = function(conf)
            return conf
          end,
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-\\>"] = "actions.select_vsplit",
          ["<C-enter>"] = "actions.select_split", -- this is used to navigate left
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["q"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        use_default_keymaps = false,
      })
    end,
  },
}
