-- File: ~/.config/nvim/lua/core/keymaps.lua
-- Last Change: Tue, Apr 2024/04/23 - 20:21:59
-- Author: Sergio Araujo
-- Reference: https://github.com/rafi/vim-config/tree/master

local mapfile = ' ' -- used to debug mappings
local Utils = require('core.utils')
local map = Utils.map
local Env = require('core.environment')
local NVIMHOME = Env.nvim_home()
local MYVIMRC = Env.myvimrc()
local ZSHHOME = Env.zsh_home()

-- Set space as my leader key
map('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {
  expr = true,
  desc = mapfile .. '<Tab> to navigate the completion menu',
})

map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {
  expr = true,
  desc = mapfile .. '<Tab> to navigate the completion menu',
})

-- It adds motions like 25j and 30k to the jump list, so you can cycle
-- through them with control-o and control-i.
-- source: https://www.vi-improved.org/vim-tips/
map('n', 'j', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], {
  expr = true,
})
map('n', 'k', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], {
  expr = true,
})

map('n', '<Leader>v', function()
  vim.cmd('edit ' .. MYVIMRC)
end, {
  desc = mapfile .. 'edit init.lua',
})

local open_command = (Utils.is_mac() == true and 'open') or 'xdg-open'

local function url_repo()
  local cursorword = vim.fn.expand('<cfile>')
  if string.find(cursorword, '^[a-zA-Z0-9-_.]*/[a-zA-Z0-9-_.]*$') then
    cursorword = 'https://github.com/' .. cursorword
  end
  return cursorword or ''
end

map('n', 'gx', function()
  vim.fn.jobstart({
    open_command,
    url_repo(),
  }, {
    detach = true,
  })
end, {
  silent = true,
  desc = mapfile .. 'xdg open link',
})

-- Jump entire buffers throughout jumplist
map('n', 'g<C-i>', function()
  Utils.jump_buffer(1)
end, {
  desc = 'Jump to newer buffer',
})

map('n', 'g<C-o>', function()
  Utils.jump_buffer(-1)
end, { desc = 'Jump to older buffer' })

map('n', '<leader>nk', function()
  local file = NVIMHOME .. '/lua/core/keymaps.lua'
  vim.cmd('edit ' .. file)
end, {
  desc = mapfile .. 'Edit keymaps',
  silent = true,
})

map('n', '<leader>na', function()
  local file = NVIMHOME .. '/lua/core/autocommands.lua'
  vim.cmd('edit ' .. file)
end, {
  desc = mapfile .. 'Edit autocommands',
  silent = true,
})

map('n', '<leader>nu', function()
  local file = NVIMHOME .. '/lua/core/utils.lua'
  vim.cmd('edit ' .. file)
end, {
  desc = mapfile .. 'Edit utils',
  silent = true,
})

map('n', '<leader>no', function()
  local file = NVIMHOME .. '/lua/core/options.lua'
  vim.cmd('edit ' .. file)
end, {
  desc = mapfile .. 'Edit options',
  silent = true,
})

map('n', '<leader>nm', '<cmd>AppendModeline<cr>', {
  desc = mapfile .. 'Add modeline at EOF',
  silent = true,
})

map('n', '<leader>m', function()
  Utils.toggle_modifiable()
end, { desc = 'Toggle modifiable' })

map('n', '<Leader>zr', function()
  local zshrc = ZSHHOME .. '/.zshrc'
  vim.cmd('edit ' .. zshrc)
end, { desc = mapfile .. '  Edit zshrc' })

map('n', '<Leader>ze', function()
  local zshenv = ZSHHOME .. '/zshenv'
  vim.cmd('edit ' .. zshenv)
end, { desc = mapfile .. '  Edit zshenv' })

map('n', '<Leader>za', function()
  local zshaliases = ZSHHOME .. '/zsh-aliases'
  vim.cmd('edit ' .. zshaliases)
end, {
  desc = mapfile .. '  Edit zsh aliases',
})

map('n', '<Leader>zf', function()
  local zshfunctions = ZSHHOME .. '/zsh-functions'
  vim.cmd('edit ' .. zshfunctions)
end, {
  desc = mapfile .. '  Edit zsh functions',
})

map({ 'n', 'i', 'v' }, '<c-s>', function()
  vim.cmd('Cls') -- personal command
  vim.cmd('update')
end, {
  desc = mapfile .. 'Buffer :update',
  silent = true,
})

map('n', '<right><right>', function()
  vim.cmd.normal('}ztj')
  if Utils.is_empty_line() then
    vim.cmd.normal('"_dd')
  end
  -- Utils.flash_cursorline()
end, {
  desc = mapfile .. 'Jump to the next block of code',
  silent = true,
})

map('n', '<left><left>', function()
  vim.cmd.normal('{{jzt')
  -- Utils.flash_cursorline()
end, {
  desc = mapfile .. 'Jump to the previous block of code',
  silent = true,
})

map('n', '<c-k>', function()
  local word = vim.fn.expand('<cword>')
  vim.cmd('help ' .. word)
end, {
  desc = mapfile .. 'help for current word',
})

-- map('n', '<c-k>', function()
--   local word = vim.fn.expand('<cword>')
--   local success, _ = pcall(vim.cmd, 'help ' .. word)
--   if not success then
--     print('Error: Failed to open help for ' .. word)
--   end
-- end, {
--   desc = mapfile .. 'help for current word',
-- })

map('n', 'i', function()
  return Utils.is_empty_line() and 'S' or 'i'
end, {
  expr = true,
  desc = 'properly indent on empty line when insert',
})

map('n', '<CR>', function()
  if not pcall(vim.cmd.normal, 'gf') then
    vim.cmd.normal('j0')
  end
end, {
  desc = mapfile .. 'gf or enter',
  noremap = true,
  silent = true,
})

map('v', '<leader>y', '"+y', {
  desc = mapfile .. 'Selection to clipboard',
})

map('n', '<M-p>', '"+]P', {
  desc = mapfile .. 'Paste clipboard',
})

map('n', '<leader>0', '"0P', {
  desc = 'Paste reg0 (cursor after)',
  silent = true,
})

map('n', '<leader>P', '"0P', {
  desc = 'Paste reg0 (cursor after)',
  silent = true,
})

map('n', '<leader>p', '"0p', {
  desc = 'Paste reg0 (cursor before)',
  silent = true,
})

map('n', '<leader>+', '"+]P', {
  desc = mapfile .. 'Paste clipboard',
})

map('i', '<M-p>', '<C-r><C-o>+', {
  desc = mapfile .. 'Paste clipboard',
})

map('n', '<leader>"', function()
  vim.cmd.normal('gsaiw"')
end, {
  desc = 'add double quote',
  silent = true,
})

map('v', '<leader>"', function()
  vim.cmd.normal('gsa"')
end, {
  desc = mapfile .. 'add double quote',
  silent = true,
})

map('n', "<leader>'", function()
  vim.cmd.normal("gsaiw'")
end, {
  desc = mapfile .. 'add single quote',
  silent = true,
})

map('v', "<leader>'", function()
  vim.cmd.normal("gsa'")
end, {
  desc = mapfile .. 'add single quote',
  silent = true,
})

map('n', '<leader>(', function()
  vim.cmd.normal('gsaiw(')
end, {
  desc = mapfile .. 'add parentesis',
  silent = true,
})

map('n', '<leader>)', function()
  vim.cmd.normal('gsaiw(')
end, {
  desc = mapfile .. 'add parentesis',
  silent = true,
})

map('n', '<leader>[', function()
  vim.cmd.normal('gsaiw[')
end, {
  desc = mapfile .. 'add brackets',
  silent = true,
})

map('n', '<leader>]', function()
  vim.cmd.normal('gsaiw[')
end, {
  desc = mapfile .. 'add brackets',
  silent = true,
})

map('n', '<leader>{', function()
  vim.cmd.normal('gsaiw{')
end, {
  desc = mapfile .. 'add angled brackets',
  silent = true,
})

map('n', '<leader>}', function()
  vim.cmd.normal('gsaiw{')
end, {
  desc = mapfile .. 'add angled brackets',
  silent = true,
})

map('n', '<leader>bf', '<cmd>lua vim.lsp.buf.format{ assync=true }<cr>', {
  desc = mapfile .. 'Format buffer',
  silent = true,
})

map('n', '<leader>bP', "<cmd>lua require('core.telescope_filepaths').list_paths()<cr>", {
  desc = mapfile .. 'Copy file path',
  silent = true,
})

map('n', '<leader>bs', function()
  Utils.squeeze_blank_lines()
end, {
  desc = mapfile .. 'Squeeze blank lines',
})

map(
  'n',
  '<leader>bb',
  "<cmd>lua require('telescope.builtin').buffers()<cr>",
  -- "<cmd>buffers<cr>:b<space>",
  {
    desc = mapfile .. 'Swich buffers',
    silent = true,
  }
)

map('n', '<leader>bd', '<cmd>bd<cr>', {
  desc = mapfile .. 'Delete buffer',
  silent = true,
})

map('n', '<leader>bn', ':bnext<CR>', {
  desc = mapfile .. 'Next buffer',
})

map('n', '<leader>bp', ':bprevious<CR>', {
  desc = mapfile .. 'Previous buffer',
})

map('n', '<leader>br', function()
  return require('telescope.builtin').oldfiles()
end, {
  desc = mapfile .. 'Recent files',
  silent = true,
})

map('n', '<leader>bS', function()
  local old_word = vim.fn.expand('<cword>')
  local new_word = vim.fn.input('Replace ' .. old_word .. ' by? ', old_word)
  if new_word ~= old_word and new_word ~= '' then
    vim.cmd(':%s/\\<' .. old_word .. '\\>/' .. new_word .. '/g')
  end
end, { desc = mapfile .. 'Substitite word in the file', silent = true })

map('n', '<leader>by', '<cmd>%y+<cr>', {
  desc = mapfile .. 'Buffer to clipboard',
  silent = true,
})

map('n', '<leader>be', '<cmd>%d<cr>', {
  desc = mapfile .. 'Erase buffer content!',
  silent = true,
})

map('n', '<leader>bu', function()
  vim.cmd('Cls') -- personal command
  vim.cmd('update')
end, {
  desc = mapfile .. 'Buffer :update',
  silent = true,
})

map('n', '<leader>bo', '<cmd>BufOnly<cr>', {
  desc = mapfile .. 'Keep just current buffer',
  silent = true,
})

map('n', '<leader>bw', '<cmd>bw!<cr>', {
  desc = mapfile .. 'Wipe buffer',
  silent = true,
})

map('v', 'y', 'ygv<Esc>', {
  desc = 'Yank and reposition cursor',
})

map('x', '<<', '<gv', {
  desc = mapfile .. 'Reselect after << on visual mode',
})

map('x', '>>', '>gv', {
  desc = mapfile .. 'Reselect after >> on visual mode',
})

map('x', '<Right>', '>gv', {
  desc = mapfile .. 'Reselect after >> on visual mode',
})

map('x', '<Left>', '<gv', {
  desc = mapfile .. 'Reselect after << on visual mode',
})

-- Better block-wise operations on selected area
local blockwise_force = function(key)
  local c_v = vim.api.nvim_replace_termcodes('<C-v>', true, false, true)
  local keyseq = {
    I = { v = '<C-v>I', V = '<C-v>^o^I', [c_v] = 'I' },
    A = { v = '<C-v>A', V = '<C-v>0o$A', [c_v] = 'A' },
    gI = { v = '<C-v>0I', V = '<C-v>0o$I', [c_v] = '0I' },
  }
  return function()
    return keyseq[key][vim.fn.mode()]
  end
end
map('x', 'I', blockwise_force('I'), { expr = true, noremap = true, desc = 'Blockwise Insert' })
map('x', 'gI', blockwise_force('gI'), { expr = true, noremap = true, desc = 'Blockwise Insert' })
map('x', 'A', blockwise_force('A'), { expr = true, noremap = true, desc = 'Blockwise Append' })

map('n', '<leader>nd', '<cmd>bd<cr>', { desc = mapfile .. 'Delete buffer', silent = true })

map('n', '<leader>nl', function()
  require('noice').cmd('last')
end, {
  desc = mapfile .. 'Show last noice message',
})

map('n', '<leader>nd', function()
  Utils.search_dotfiles()
end, {
  desc = mapfile .. 'Edit dotfiles',
  silent = true,
})

map('n', '<leader>nw', '<cmd>Wiki<cr>', {
  desc = mapfile .. 'Edit my wiki files',
  silent = true,
})

map('n', '<Leader>nf', "<cmd>lua require('core.files').nvim_files()<CR>", {
  desc = mapfile .. 'Edit nvim files',
})

map('n', '<Leader>np', "<cmd>lua require('core.files').nvim_plugins()<CR>", {
  desc = mapfile .. 'Edit nvim plugins',
})

map('n', '<Leader>nc', "<cmd>lua require('core.files').nvim_core()<CR>", { desc = mapfile .. 'Edit nvim core' })

map('n', '<leader>nr', ':lua require("core.files").search_oldfiles()<cr>', {
  desc = mapfile .. 'Recent files',
})

-- map(
--   'n',
--   '<leader>nR',
--   ':lua require("core.utils").Ranger()<cr>',
--   {
--     desc = mapfile .. 'Ranger file manager',
--   }
-- )

map('n', '<leader>ca', '<cmd>UpdateAll<cr>', {
  desc = mapfile .. 'Update Mason and Tresitter',
  silent = true,
})

map('n', '<leader>cd', '<cmd>ToggleDiagnostics<cr>', {
  desc = mapfile .. 'Diagnostic toggle',
  silent = true,
})

map('n', '<leader>ce', vim.diagnostic.enable, {
  desc = mapfile .. 'Diagnostic enable',
  silent = true,
})

map('n', '<leader>cf', vim.diagnostic.open_float, {
  desc = mapfile .. 'Diagnostic open float',
  silent = true,
})

map('n', '<leader>cn', vim.diagnostic.goto_next, {
  desc = mapfile .. 'Diagnostic next',
  silent = true,
})

map('n', '<leader>cp', vim.diagnostic.goto_prev, {
  desc = mapfile .. 'Diagnostic prev',
  silent = true,
})

map('n', '<leader>cl', vim.diagnostic.setloclist, {
  desc = mapfile .. 'Diagnostic list',
  silent = true,
})

map('n', '<Leader>cw', '*Ncgn', {
  desc = mapfile .. 'Change current word',
  silent = true,
})

map('n', '<leader>tB', '<cmd>ToggleBackground<cr>', {
  desc = mapfile .. 'Toggle background',
  silent = true,
})

map('n', '<leader>tl', function()
  Utils.toggle_list()
end, {
  desc = mapfile .. 'Toggle list',
  silent = true,
})

map('n', '<leader>tc', '<cmd>lua require("core.utils").ToggleConcealLevel()<cr>', {
  desc = mapfile .. 'Toggle conceal level',
})

map('n', '<leader>tb', function()
  Utils.bipolar()
end, {
  desc = mapfile .. 'Toggle boolean',
  silent = true,
})

map('n', '<leader>tm', function()
  Utils.toggle_modifiable()
end, { desc = 'Toggle modifiable' })

map('n', '<leader>td', '<cmd>ToggleDiagnostics<cr>', {
  desc = mapfile .. 'Toggle diagnostcs',
  silent = true,
})

map('n', '<M-Right>', '<cmd>lua vim.diagnostic.goto_next({float={source=true}})<cr>', {
  desc = 'Jump to the next diagnostic',
  silent = true,
})

map('n', '<M-Left>', '<cmd>lua vim.diagnostic.goto_prev({float={source=true}})<cr>', {
  desc = 'Jump to the prev diagnostic',
  silent = true,
})

map('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', {
  desc = mapfile .. 'LSP identifier rename',
})

map('n', '<leader>cR', '<cmd>lua require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/luasnip/"})<cr>', {
  desc = mapfile .. 'reload snippets',
  silent = false,
})

map('n', '<leader>cs', '<cmd>LuaSnipEdit<cr>', { desc = mapfile .. 'Edit snippets' })

map('n', '<M-s>', function()
  Utils.squeeze_blank_lines()
end, {
  desc = mapfile .. 'Squeeze blank lines',
})

map('n', 'Y', 'yg_', {
  desc = mapfile .. 'Copy until the end of line',
})

map('n', '<leader>cb', function()
  Utils.bipolar()
end, {
  desc = mapfile .. 'Toggle boolean',
  silent = true,
})

map('n', 'dd', function()
  return Utils.is_empty_line() and '"_dd' or 'dd'
end, {
  expr = true,
  desc = mapfile .. 'delete blank lines to black hole register',
})

map('n', '<leader>x', function()
  -- https://stackoverflow.com/a/47074633
  -- https://codereview.stackexchange.com/a/282183

  local results = {}
  local buffers = vim.api.nvim_list_bufs()

  for _, buffer in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buffer) then
      local filename = vim.api.nvim_buf_get_name(buffer)
      if filename ~= '' then
        table.insert(results, filename)
      end
    end
  end
  local curr_buf = vim.api.nvim_buf_get_name(0)
  if #results > 1 or curr_buf == '' then
    vim.cmd('update | bdelete')
  else
    vim.cmd('quit!')
  end
end, {
  silent = false,
  desc = mapfile .. 'bd or quit',
})

map('n', '<leader>w', '<cmd>bw!<cr>', { desc = 'Wipe buffer', silent = true })

map('n', '<c-6>', '<c-^>\'"zz', {
  silent = true,
  noremap = true,
  desc = 'Jump to alternate buffer',
})

map(
  'n',
  '<leader>un',
  '<cmd>let [&nu, &rnu] = [!&rnu, &nu+&rnu==1]<cr>',
  { desc = 'Toggle number and relative number' }
)

map('n', '<leader>uc', '<cmd>lua require("core.utils").ToggleConcealLevel()<cr>', {
  desc = mapfile .. 'Toggle conceal level',
})

map('n', '<leader>ul', function()
  Utils.toggle_list()
end, {
  desc = mapfile .. 'Toggle list',
  silent = true,
})

map('n', '<leader>um', function()
  local cmd = Utils.is_loaded('noice.lua') and 'Noice' or 'messages'
  vim.cmd(cmd)
end, {
  desc = mapfile .. 'Show messages',
  silent = true,
})

map('n', '<leader>ud', '<cmd>ToggleDiagnostics<cr>', {
  desc = mapfile .. 'Toggle diagnostcs',
  silent = true,
})

map('n', '<leader>uu', '<cmd>SwitchColor<cr>', {
  desc = mapfile .. 'Switch color',
  silent = true,
})

map( -- the actual command is defined in commands.
  'n',
  '<leader>us',
  '<cmd>ToggleSpell<cr>',
  {
    desc = mapfile .. 'Toggle spell',
  }
)

map('n', '<m-1>', '1z=', {
  desc = mapfile .. 'Accept first spell suggestion',
  silent = true,
})

map('n', '<leader>ut', '<cmd>ChangeColor<cr>', {
  desc = 'desc',
  silent = true,
})

-- cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
-- cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"
map('c', '<c-j>', [[wildmenumode() ? "\<c-j>" : "\<down>"]], { expr = true })
map('c', '<c-k>', [[wildmenumode() ? "\<c-k>" : "\<up>"]], { expr = true })

map('c', '<c-a>', '<Home>', {
  desc = 'cmd jump home',
  silent = true,
})

map('c', '<c-e>', '<End>', {
  desc = 'cmd jump $',
  silent = true,
})

map('x', 'il', 'g_o_', {
  desc = 'Inner line',
  silent = true,
})

map('o', 'il', '<cmd>normal vil<cr>', {
  desc = 'Inner line',
  silent = true,
})

map('x', 'al', '$o0', {
  desc = 'Arrownd line',
  silent = true,
})

map('o', 'al', ':normal val<cr>', {
  desc = 'Arrownd line',
  silent = true,
})

map('n', '<leader>ll', function()
  return require('lazy').home()
end, { desc = mapfile .. 'Lazy home' })

map('n', '<leader>lu', function()
  return require('lazy').update()
end, {
  desc = mapfile .. 'Lazy update',
})

map('n', '<leader>ls', function()
  return require('lazy').sync()
end, {
  desc = mapfile .. 'Lazy sync',
})

map('n', '<leader>lL', function()
  return require('lazy').log()
end, { desc = mapfile .. 'Lazy log' })

map('n', '<leader>lc', function()
  return require('lazy').clean()
end, {
  desc = mapfile .. 'Lazy clean',
})

map('n', '<leader>lp', function()
  return require('lazy').profile()
end, {
  desc = mapfile .. 'Lazy profile',
})

-- Resize splits with arrow keys
map('n', '<C-Up>', '<cmd>resize +2<CR>')
map('n', '<C-Down>', '<cmd>resize -2<CR>')
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>')
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>')
