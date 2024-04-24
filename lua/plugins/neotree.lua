-- File: ~/.config/nvim/lua/plugins/neotree.lua
-- Last Change: Wed, Mar 2024/03/13 - 05:25:10

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },

  opts = {
    source_selector = {
      winbar = true,
      statusline = false
    },
    window = {
      mappings = {
        ['e'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
        ['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
        ['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
      },
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function(file_path)
          -- auto close
          -- vimc.cmd("Neotree close")
          -- OR
          require("neo-tree.command").execute({ action = "close" })
        end
      },
    },
  },

  keys = {
    { '<M-e>', '<cmd>Neotree toggle<cr>', desc = 'Toggle neotree (plugin)' },
  }
}
