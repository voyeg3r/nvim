-- File: ~/.config/nvim/lua/plugins/undo.lua
-- Last Change: Tue, Feb 2024/02/06 - 11:38:42

return {
  "mbbill/undotree",
  event = "VeryLazy",
  keys = {
    {
      "<leader>cu",
      "<cmd>UndotreeToggle<cr>",
      desc = "Toggle Undotree",
    },
  },
}
