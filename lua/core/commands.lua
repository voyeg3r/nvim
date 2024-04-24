-- Filename: ~/.config/nvim/lua/core/commands.lua
-- Last Change: Fri, 09 Dec 2022 - 19:18

local Utils = require('core.utils')
local user_cmd = vim.api.nvim_create_user_command

-- Define the abbreviation pairs in a table
local cmdabbrev = {
  ['W'] = 'w',
  ['Wq'] = 'wq',
  ['wQ'] = 'wq',
  ['WQ'] = 'wq',
  ['Q'] = 'q',
}

-- Use a for loop to create the abbreviations
for abbreviation, command in pairs(cmdabbrev) do
  vim.cmd('cnoreabbrev ' .. abbreviation .. ' ' .. command)
end

local insertabrev = {
  ['adn'] = 'and',
  ['cehck'] = 'check',
  ['heigth'] = 'height',
  ['taht'] = 'that',
  ['teh'] = 'the',
  ['tehn'] = 'then',
  ['tihs'] = 'this',
  ['waht'] = 'what',
  ['whcih'] = 'which',
}

-- Use a for loop to create the abbreviations
for abbreviation, command in pairs(insertabrev) do
  vim.cmd('inoreabbrev ' .. abbreviation .. ' ' .. command)
end

user_cmd('ReloadConfig', function()
  for name, _ in pairs(package.loaded) do
    if name:match('^plugins') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify('Nvim configuration reloaded!', vim.log.levels.INFO)
end, {})

user_cmd('AppendModeline', 'lua require("core.utils").append_modeline()', {
  desc = 'Add modeline at the end of current buffer',
  nargs = 0,
  bang = true,
})

user_cmd('LspSignature', 'lua vim.lsp.buf.signature_help()', {
  nargs = '+',
})

user_cmd('LspHover', 'lua vim.lsp.buf.hover()', {
  nargs = '+',
})

user_cmd('LineWiseClipboard', 'lua require("core.utils").linewise_clipboard()', {
  nargs = 0,
})

user_cmd('BlokwiseClipboard', 'lua require("core.utils").blockwise_clipboard()', {
  nargs = 0,
  desc = 'Turn clipboard into blockwise',
})

user_cmd('Dos2unix', 'lua require("core.utils").dosToUnix()', {
  nargs = 0,
  desc = 'Convert file to unix format',
})

user_cmd('NewFileDialog', function(_)
  vim.ui.input({ prompt = 'New file path: ' }, function(txt)
    if txt == nil then
      return
    end
    txt = vim.trim(txt)
    if txt == '' then
      return
    end
    vim.cmd('e ' .. txt)
  end)
end, {
  nargs = 0,
  desc = 'New file dialog',
})

-- vim.cmd("command! -nargs=1 SubstituteAndSet lua substituteAndSet(<f-args>)")

user_cmd('RenameIdentifier', function()
  vim.lsp.buf.rename()
end, { desc = 'Lsp rename' })

user_cmd('ClearBuffer', 'enew | bd! #', {
  nargs = 0,
  bang = true,
})

user_cmd('CopyUrl', 'let @+=expand("<cfile>")', {
  nargs = 0,
  bang = true,
  desc = 'Copy <cfile> to clipboard',
})

user_cmd('CopyBuffer', '%y+', {
  nargs = 0,
  bang = true,
  desc = 'Copy the whole file to clipboard',
})

user_cmd('HarponDel', 'lua require("harpoon.mark").rm_file()', {
  nargs = 0,
  bang = true,
})

user_cmd('BlockwiseZero', 'lua require("core.utils").blockwise_register("0")', {
  nargs = '?',
  bang = false,
})

user_cmd('BlockwisePlus', 'lua require("core.utils").blockwise_clipboard()', {
  nargs = '?',
  bang = false,
})

user_cmd('BlockwisePrimary', 'lua require("core.utils").blockwise_register("*")', {
  nargs = '?',
  bang = false,
})

user_cmd('BlockwiseClipboard', 'lua require("core.utils").blockwise_clipboard()', {
  nargs = '?',
  bang = false,
})

vim.cmd([[cnoreab Bz BlockwiseZero]])
vim.cmd([[cnoreab B+ BlockwisePlus]])
vim.cmd([[cnoreab B* BlockwisePrimary]])

user_cmd('Dos2unix', 'lua require("core.utils").dosToUnix()<CR>', {
  nargs = 0,
  bang = true,
  desc = 'Convert dos 2 unix',
})

user_cmd('ToggleBackground', 'lua require("core.utils").toggle_background()<cr>', {
  nargs = 0,
})

user_cmd(
  'SwitchColor',
  -- 'lua require("core.utils").toggle_colors()<cr>',
  'lua require("core.utils").choose_colors()<cr>',
  {
    nargs = 0,
    desc = 'Change color',
  }
)

user_cmd('ChangeColor', 'lua require("core.utils").toggle_colors()<cr>', {
  desc = 'desc',
  nargs = 0,
  bang = true,
})

user_cmd('TogglePairs', 'lua require("core.utils").toggle_autopairs()<cr>', {
  nargs = 0,
  desc = 'Toggle autopairs',
})

user_cmd('ToggleSpell', 'lua require("core.utils").toggle_spell()<cr>', {
  nargs = 0,
  desc = 'Toggle spell',
})

user_cmd('ToggleDiagnostics', function()
  Utils.toggle_diagnostics()
end, {
  desc = 'Toggle lsp diagnostic',
  nargs = 0,
  bang = true,
})

user_cmd('Transparency', function()
  Utils.toggle_transparency()
end, {
  desc = 'Toggle transparency',
  nargs = 0,
  bang = true,
})

user_cmd('Wiki', 'lua require("core.files").wiki()<CR>', {
  desc = 'Search on my wiki',
})

user_cmd('UpdateAll', function()
  vim.cmd([[TSUpdateSync]])
  vim.cmd([[MasonUpdate]])
end, {
  desc = 'Update treesitter and mason',
})

user_cmd('LuaSnipEdit', function()
  Utils.edit_snippets()
end, {
  desc = 'Edit your snippets',
})

user_cmd('Cor', 'lua print(vim.g.colors_name)<cr>', {
  desc = 'show current colorscheme',
})

user_cmd('SnipList', function()
  pcall(function()
    Utils.list_snips()
  end)
end, { desc = 'List avaiable snippets' })

vim.cmd([[cnoreab Cb ClearBuffer]])
vim.cmd([[cabbrev vb vert sb]]) --vertical split buffer :vb <buffer>
vim.cmd([[cnoreab cls Cls]])

-- vim.cmd([[command! Cls lua require("core.utils").preserve('%s/\\s\\+$//ge')]])
user_cmd('Cls', function()
  Utils.preserve([[%s/\s\+$//ge]])
end, { desc = 'Remove space in the end of lines' })

-- vim.cmd([[command! Reindent lua require('core.utils').preserve("sil keepj normal! gg=G")]])

user_cmd('Reindent', function()
  Utils.preserve('sil keepj normal! gg=G')
end, { desc = 'desc', nargs = 0, bang = true })

user_cmd('Format', 'lua vim.lsp.buf.format{assync=true}<cr>', {
  desc = 'Format buffer',
  nargs = 0,
})

vim.cmd([[highlight MinhasNotas ctermbg=Yellow ctermfg=red guibg=Yellow guifg=red]])

vim.cmd([[match MinhasNotas /NOTE:/]])

-- vim.cmd([[command! BufOnly lua require('core.utils').preserve("silent! %bd|e#|bd#")]])

user_cmd('BufOnly', function()
  pcall(function()
    Utils.preserve('silent! up|%bd|e#|bd#')
  end)
end, { desc = 'Close every other buffer' })

vim.cmd([[cnoreab Bo BufOnly]])
vim.cmd([[cnoreab W w]])
vim.cmd([[cnoreab W! w!]])

user_cmd('CloseAllBuffer', function()
  vim.cmd('wa')
  local bufs = api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    api.nvim_buf_delete(buf, {})
  end
end, {
  desc = 'save & delete all buffers',
})

-- vim.cmd([[command! CloneBuffer new | 0put =getbufline('#',1,'$')]])

user_cmd('CloneBuffer', "new | 0put =getbufline('#',', '$')", {
  nargs = 0,
  bang = true,
})

-- vim.cmd([[command! Mappings drop ~/.config/nvim/lua/user/mappings.lua]])
vim.cmd([[command! Scratch new | setlocal bt=nofile bh=wipe nobl noswapfile nu]])
vim.cmd([[syntax sync minlines=64]]) --  faster syntax hl

user_cmd('Delblank', function()
  Utils.squeeze_blank_lines()
end, {
  desc = 'Squeeze blank lines',
  nargs = 0,
  bang = true,
})

user_cmd('Old', 'Telescope oldfiles', {
  desc = 'List oldfiles (open)',
})

user_cmd('Blockwise', function()
  Utils.blockwise_clipboard()
end, {
  desc = 'Make + register blockwise',
  nargs = 0,
  bang = true,
})

user_cmd('FilePath', "lua require('core.telescope_filepaths').list_paths()", {
  desc = 'Copy file path',
  nargs = 0,
  bang = true,
})

vim.cmd([[cnoreab Bw Blockwise]])

-- Use ':Grep' or ':LGrep' to grep into quickfix|loclist
-- without output or jumping to first match
-- Use ':Grep <pattern> %' to search only current file
-- Use ':Grep <pattern> %:h' to search the current file dir
vim.cmd('command! -nargs=+ -complete=file Grep noautocmd grep! <args> | redraw! | copen')
vim.cmd('command! -nargs=+ -complete=file LGrep noautocmd lgrep! <args> | redraw! | lopen')

-- save as root, in my case I use the command 'doas'
vim.cmd([[cmap w!! w !doas tee % >/dev/null]])
vim.cmd([[command! SaveAsRoot w !doas tee %]])

-- vim.cmd('inoreabbrev idate <c-r>=strftime("%a, %d %b %Y %T")<cr>')
vim.cmd([[cnoreab cls Cls]])

user_cmd('BiPolar', function(_)
  local moods_table = {
    ['true'] = 'false',
    ['false'] = 'true',
    ['on'] = 'off',
    ['off'] = 'on',
    ['Up'] = 'Down',
    ['Down'] = 'Up',
    ['up'] = 'down',
    ['down'] = 'up',
    ['enable'] = 'disable',
    ['disable'] = 'enable',
    ['no'] = 'yes',
    ['yes'] = 'no',
  }
  local cursor_word = vim.api.nvim_eval("expand('<cword>')")
  if moods_table[cursor_word] then
    vim.cmd('normal ciw' .. moods_table[cursor_word] .. '')
  end
end, {
  desc = 'Switch Moody Words',
  force = true,
})
