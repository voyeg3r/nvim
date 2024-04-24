-- File: ~/.config/nvim/lua/plugins/improved-ft.lua
-- Last Change: Sat, Dec 2023/12/02 - 08:04:52

return {
  "backdround/improved-ft.nvim",
  opts = {
    use_default_mappings = true,
  },
  keys = {
    { 'f', 'f' , desc = 'Jump forward to char'},
    { 'F', 'F' , desc = 'Jump backward to char'},
    { 't', 't' , desc = 'Jump forward before char'},
    { 'T', 'T' , desc = 'Jump backward before char'},
    { ';', ';' , desc = 'Repear jump forward'},
    { ',', ',' , desc = 'Repeat jump backward '},
  }
}
