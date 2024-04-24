-- File: ~/.config/nvim/lua/plugins/noice.lua
-- Last Change: Sat, Dec 2023/12/16 - 15:40:28

-- @used to debug mapoings
local mapfile = ' '

return {
  "folke/noice.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {
    routes = { {
      view = "cmdline",
      -- view = "notify",
      filter = { event = "msg_showmode" },
    }, },
    lsp = {
      -- override markdown rendering so that
      -- **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },

    -- command_palette = true,
    -- position the cmdline and popupmenu together
    -- bottom_search = true,

    presets = {
      bottom_search = false,
      -- position the cmdline and popupmenu together
      command_palette = true,
      -- long messages will be sent to a split
      long_message_to_split = true,
      -- enables an input dialog for inc-rename.nvim
      inc_rename = false,
      -- add a border to hover docs and signature help
      lsp_doc_border = false,
    },

  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      "rcarriga/nvim-notify",
      keys = {
        {
          "<leader>un",
          function()
            require("notify").dismiss({ silent = true, pending = true })
          end,
          desc = mapfile .. "Dismiss all Notifications",
        },
      },
    },
  }
}
