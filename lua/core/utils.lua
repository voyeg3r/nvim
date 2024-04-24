-- Fname: ~/.config/nvim/lua/core/utils.lua
-- Last Change: Wed, 01 Jun 2022 08:19
-- https://github.com/ibhagwan/nvim-lua/blob/main/lua/utils.lua

local user_cmd = vim.api.nvim_create_user_command
local execute = vim.api.nvim_command
local vim = vim
local opt = vim.opt -- global
local g = vim.g -- global for let options
local wo = vim.wo -- window local
local bo = vim.bo -- buffer local
local fn = vim.fn -- access vim functions
local cmd = vim.cmd -- vim commands
local api = vim.api -- access vim api

local M = {}

-- @return home
M.get_homedir = function()
  return os.getenv('HOME')
end

--@returs the word count
M.count_words = function()
  return tostring(vim.fn.wordcount().words)
end

--@test if a string is nil or empty
M.isempty = function(s)
  return s == nil or s == ''
end

M.is_empty_line = function()
  local current_line = vim.api.nvim_get_current_line()
  return current_line:match('^%s*$') ~= nil
end

M.is_executable = function(file)
  local v = vim.api.nvim_exec2('!file ' .. file, { output = true })
  if string.find(v.output, 'executable', 0, true) then
    return true
  else
    return false
  end
end

-- --@retun true if is in markdown list
-- M.is_in_list = function()
--   local current_line = vim.api.nvim_get_current_line()
--   return current_line:match('%s*[%*-+]%s') ~= nil
-- end
--
-- M.is_in_num_list = function()
--   local current_line = vim.api.nvim_get_current_line()
--   return current_line:match("^%s*%d+%s-%s") ~= nil
-- end

--@params condition true false
M.ternary = function(cond, T, F)
  if cond then
    return T
  else
    return F
  end
end

--@uppercase first letter
M.firstToUpper = function(str)
  return (str:gsub('^%l', string.upper))
end

--@test if a package is loaded (normally plugins)
M.is_loaded = function(plugin_name)
  return package.loaded[plugin_name] ~= nil
end

--@ returns true or false (detects macro running)
M.is_recording = function()
  return vim.fn.reg_recording() ~= nil
end

-- @param module name
M.safeRequire = function(module)
  local success, loadedModule = pcall(require, module)
  if success then
    return loadedModule
  else
    vim.notify('Error loading ' .. module, vim.log.levels.ERROR)
  end
end

-- https://www.reddit.com/r/neovim/comments/1b1sv3a/function_to_get_visually_selected_text/
--- Return the visually selected text as an array with an entry for each line
---
--- @return string[]|nil lines The selected text as an array of lines.
M.get_visual_selection_text = function()
  local _, srow, scol = unpack(vim.fn.getpos('v'))
  local _, erow, ecol = unpack(vim.fn.getpos('.'))

  -- visual line mode
  if vim.fn.mode() == 'V' then
    if srow > erow then
      return vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
    else
      return vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
    end
  end

  -- regular visual mode
  if vim.fn.mode() == 'v' then
    if srow < erow or (srow == erow and scol <= ecol) then
      return vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
    else
      return vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
    end
  end

  -- visual block mode
  if vim.fn.mode() == '\22' then
    local lines = {}
    if srow > erow then
      srow, erow = erow, srow
    end
    if scol > ecol then
      scol, ecol = ecol, scol
    end
    for i = srow, erow do
      table.insert(
        lines,
        vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1]
      )
    end
    return lines
  end
end

M.removeOldFiles = function(pattern)
  local oldfiles = vim.v.oldfiles
  for i = #oldfiles, 1, -1 do
    if oldfiles[i]:match(pattern) then
      table.remove(oldfiles, i)
    end
  end
  vim.v.oldfiles = oldfiles
end

-- toggle_autopairs() -- <leader>tp -- toggle autopairs
M.toggle_autopairs = function()
  local ok, autopairs = pcall(require, 'nvim-autopairs')
  if ok then
    -- if autopairs.state.disabled then
    if MPairs.state.disabled then
      autopairs.enable()
      vim.notify('autopairs on')
    else
      autopairs.disable()
      vim.notify('autopairs off')
    end
  else
    vim.notifylrrr('autopairs not available')
  end
end

M.toggleInlayHints = function()
  vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
end

--that pressing `.` will repeat the action.
--Example: `vim.keymap.set('n', 'ct', dot_repeat(function() print(os.clock()) end), { expr = true })`
--Setting expr = true in the keymap is required for this function to make the keymap repeatable
--based on gist: https://gist.github.com/kylechui/a5c1258cd2d86755f97b10fc921315c3
M.dot_repeat = function(
  callback --[[Function]]
)
  return function()
    _G.dot_repeat_callback = callback
    vim.go.operatorfunc = 'v:lua.dot_repeat_callback'
    return 'g@l'
  end
end

M.vim_opt_toggle = function(opt, on, off, name)
  local message = name
  if vim.opt[opt]:get() == off then
    vim.opt[opt] = on
    message = message .. ' Enabled'
  else
    vim.opt[opt] = off
    message = message .. ' Disabled'
  end
  vim.notify(message)
end

-- https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
-- https://oroques.dev/notes/neovim-init/
M.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

M.toggle_quicklist = function()
  if fn.empty(fn.filter(fn.getwininfo(), 'v:val.quickfix')) == 1 then
    vim.cmd('copen')
  else
    vim.cmd('cclose')
  end
end

M.toggle_spell = function()
  vim.wo.spell = not vim.wo.spell
  local status = (vim.wo.spell == true and 'Enabled' or 'Disabled')
  vim.notify('Spell checking: ' .. status, vim.log.levels.INFO)
end

M.ToggleConcealLevel = function()
  vim.o.conceallevel = (vim.o.conceallevel == 0) and 2 or 0
  vim.notify('ConcealLevel set to: ' .. vim.o.conceallevel, vim.log.levels.INFO)
end

M.edit_snippets = function()
  local status_ok, luasnip = pcall(require, 'luasnip')
  if status_ok then
    -- require("luasnip.loaders.from_lua").edit_snippet_files()
    require('luasnip.loaders').edit_snippet_files()
  end
end

M.insert_snippet_template = function()
  local snips = require('luasnip').get_snippets()[vim.bo.filetype]
  if snips then
    for _, snip in ipairs(snips) do
      if snip['name'] == '_skel' then
        require('luasnip').snip_expand(snip)
        return true
      end
    end
  end
  return false
end

M.toggle_background = function()
  local current_bg = vim.opt.background:get()
  vim.opt.background = (current_bg == 'light') and 'dark' or 'light'
end

-- M.blockwise_clipboard = function()
--   local clipboard_content = vim.fn.getreg('+')
--   vim.fn.setreg('+', clipboard_content, 'b')
-- end

M.blockwise_clipboard = function()
  -- vim.cmd("call setreg('+', @+, 'b')")
  vim.cmd("call setreg('+', getreg('+'), 'b')")
  print('set + reg: blockwise!')
end

M.blockwise_register = function(register)
  register = register or '+'
  print('Making ' .. register .. ' blockwise')
  -- vim.cmd("call setreg('+', @+, 'b')") -- native vim way to set clipboard blockwise
  vim.cmd("call setreg('" .. register .. "', @" .. register .. ", 'b')")
end

-- vim.api.nvim_create_user_command('BlockwiseZero', ':lua require("core.utils").blockwise_register("0")<CR>', { nargs = '?', bang = false})
-- vim.api.nvim_create_user_command('BlockwisePlus', ':lua require("core.utils").blockwise_register("+")<CR>', { nargs = '?', bang = false})
-- vim.api.nvim_create_user_command('BlockwisePrimary', ':lua require("core.utils").blockwise_register("*")<CR>', { nargs = '?', bang = false})
-- vim.cmd([[cnoreab Bz BlockwiseZero]])
-- vim.cmd([[cnoreab B+ BlockwisePlus]])
-- vim.cmd([[cnoreab B* BlockwisePrimary]])

-- this helps us paste a line from the clipboard that
-- has a new line
-- call setreg('+',getreg('+'),'b')
M.linewise_clipboard = function()
  vim.cmd("call setreg('+', getreg('+'), 'l')")
  print('set + reg: linewise!')
end

--@no param returns system string like: linux
-- lua print(require("core.utils").system())
M.system = function()
  return vim.loop.os_uname().sysname:lower()
end

M.is_mac = function()
  return vim.loop.os_uname().sysname == 'Darwin'
end

M.is_linux = function()
  return vim.loop.os_uname().sysname == 'Linux'
end

-- source: https://www.reddit.com/r/neovim/comments/109018y/comment/j3vdaux/
M.list_snips = function()
  local ft_list = require('luasnip').available()[vim.o.filetype]
  local ft_snips = {}
  for _, item in pairs(ft_list) do
    ft_snips[item.trigger] = item.name
  end
  print(vim.inspect(ft_snips))
end

-- that's a false mistake
-- source: https://github.com/sagarrakshe/toggle-bool/blob/master/plugin/toggle_bool.py

-- https://www.reddit.com/r/vim/comments/p7xcpo/comment/h9nw69j/
--M.MarkdownHeaders = function()
--   local filename = vim.fn.expand("%")
--   local lines = vim.fn.getbufline('%', 0, '$')
--   local lines = vim.fn.map(lines, {index, value -> {"lnum": index + 1, "text": value, "filename": filename}})
--   local vim.fn.filter(lines, {_, value -> value.text =~# '^#\+ .*$'})
--   vim.cmd("call setqflist(lines)")
--   vim.cmd("copen")
--end
-- nmap <M-h> :cp<CR>
-- nmap <M-l> :cn<CR>

-- References
-- https://bit.ly/3HqvgRT
M.CountWordFunction = function()
  local hlsearch_status = vim.v.hlsearch
  local old_query = vim.fn.getreg('/') -- save search register
  local current_word = vim.fn.expand('<cword>')
  vim.fn.setreg('/', current_word)
  local wordcount = vim.fn.searchcount({ maxcount = 1000, timeout = 500 }).total
  local current_word_number = vim.fn.searchcount({ maxcount = 1000, timeout = 500 }).current
  vim.fn.setreg('/', old_query) -- restore search register
  print('[' .. current_word_number .. '/' .. wordcount .. ']')
  -- Below we are using the nvim-notify plugin to show up the count of words
  vim.cmd([[highlight CurrenWord ctermbg=LightGray ctermfg=Red guibg=LightGray guifg=Black]])
  vim.cmd([[exec 'match CurrenWord /\V\<' . expand('<cword>') . '\>/']])
  -- require("notify")("word '" .. current_word .. "' found " .. wordcount .. " times")
end

local transparency = 0
M.toggle_transparency = function()
  if transparency == 0 then
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    local transparency = 1
  else
    vim.cmd('hi Normal guibg=#111111 ctermbg=black')
    local transparency = 0
  end
end
-- -- map('n', '<c-s-t>', '<cmd>lua require("core.utils").toggle_transparency()<br>')

-- TODO: change colors forward and backward
M.toggle_colors = function()
  local current_color = vim.g.colors_name
  if current_color == 'gruvbox' then
    -- gruvbox light is very cool
    vim.cmd('colorscheme ayu-mirage')
    -- vim.cmd('colo')
    -- vim.cmd('redraw')
  elseif current_color == 'ayu' then
    vim.cmd('colorscheme catppuccin')
    -- vim.cmd('colo')
    -- vim.cmd('redraw')
  elseif current_color == 'catppuccin-mocha' then
    vim.cmd('colorscheme material')
    -- vim.cmd('colo')
    -- vim.cmd('redraw')
  elseif current_color == 'material' then
    vim.cmd('colorscheme rose-pine')
    -- vim.cmd('colo')
    -- vim.cmd('redraw')
  elseif current_color == 'rose-pine' then
    vim.cmd('colorscheme nordfox')
    -- vim.cmd('colo')
    -- vim.cmd('redraw')
  elseif current_color == 'nordfox' then
    vim.cmd('colorscheme monokai')
    -- vim.cmd('colo')
    -- vim.cmd('redraw')
  elseif current_color == 'monokai' then
    vim.cmd('colorscheme tokyonight')
    -- vim.cmd('colo')
    -- vim.cmd('redraw')
  else
    --vim.g.tokyonight_transparent = true
    vim.cmd('colorscheme gruvbox')
    -- vim.cmd('colo')
    -- vim.cmd('redraw')
  end
end

-- https://vi.stackexchange.com/questions/31206
-- https://vi.stackexchange.com/a/36950/7339
-- @ lua require('core.utils').flash_cursorline()
M.flash_cursorline = function()
  local cursorline_state = vim.opt.cursorline:get()
  vim.opt.cursorline = true
  cursor_pos = vim.fn.getpos('.')
  vim.cmd([[hi CursorLine guifg=#FFFFFF guibg=#FF9509]])
  vim.fn.timer_start(200, function()
    vim.cmd([[hi CursorLine guifg=NONE guibg=NONE]])
    vim.fn.setpos('.', cursor_pos)
    if cursorline_state == false then
      vim.opt.cursorline = false
    end
  end)
end

-- https://www.reddit.com/r/neovim/comments/rnevjt/comment/hps3aba/
M.ToggleQuickFix = function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd([[cclose]])
  else
    vim.cmd([[copen]])
  end
end
vim.cmd([[command! -nargs=0 -bar ToggleQuickFix lua require('core.utils').ToggleQuickFix()]])
vim.cmd([[cnoreab TQ ToggleQuickFix]])
vim.cmd([[cnoreab tq ToggleQuickFix]])

-- dos2unix
M.dosToUnix = function()
  M.preserve([[%s/\%x0D$//e]])
  vim.bo.fileformat = 'unix'
  vim.bo.bomb = true
  vim.opt.encoding = 'utf-8'
  vim.opt.fileencoding = 'utf-8'
end

-- vim.diagnostic.goto_prev,
-- vim.diagnostic.open_float
-- vim.diagnostic.setloclist
M.toggle_diagnostics = function()
  if vim.diagnostic.is_disabled() then
    vim.diagnostic.enable()
    vim.notify('Diagnostic enabled')
  else
    vim.diagnostic.disable()
    vim.notify('Diagnostic disabled')
  end
end

--@source: r/neovim/comments/uq85hr/comment/i8piu91/
M.toggle_list = function()
  vim.opt.list = not (vim.opt.list:get())
  local status = vim.opt.list:get()
  print('List: ' .. (status and 'Enabled' or 'Disabled'))
end

--@toggles boolean under cursor
M.bipolar = function(_)
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
end

M.buf_modified = function()
  local buf = vim.api.nvim_get_current_buf()
  return vim.api.nvim_buf_get_option(buf, 'modified')
end

M.toggle_modifiable = function()
  vim.bo.modifiable = not vim.bo.modifiable
  local status = (vim.bo.modifiable == true and 'Modifiable' or 'Read only')
  vim.notify('Buffer is: ' .. status, vim.log.levels.INFO)
end

M.squeeze_blank_lines = function()
  -- references: https://vi.stackexchange.com/posts/26304/revisions
  if vim.bo.binary == false and vim.opt.filetype:get() ~= 'diff' then
    local old_query = vim.fn.getreg('/') -- save search register
    M.preserve([[sil! 1,.s/^\n\{2,}/\r/gn]]) -- set current search count number
    local result = vim.fn.searchcount({ maxcount = 1000, timeout = 500 }).current
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    M.preserve([[sil! keepp keepj %s/^\n\{2,}/\r/ge]])
    M.preserve([[sil! keepp keepj %s/^\s\+$/\r/ge]])
    M.preserve([[sil! keepp keepj %s/\v($\n\s*)+%$/\r/e]])
    -- vim.notify('Removed duplicated blank ines')
    if result > 0 then
      vim.api.nvim_win_set_cursor(0, { (line - result), col })
    end
    vim.fn.setreg('/', old_query) -- restore search register
  end
end

M.is_executable = function()
  local file = vim.fn.expand('%:p')
  local type = vim.fn.getftype(file)
  if type == 'file' then
    local perm = vim.fn.getfperm(file)
    if string.match(perm, 'x', 3) then
      return true
    else
      return false
    end
  end
end

M.increment = function(par, inc)
  return par + (inc or 1)
end

M.reload_module = function(...)
  return require('plenary.reload').reload_module(...)
end

M.rerequire_module = function(name)
  M.reload_module(name)
  return require(name)
end

M.preserve = function(arguments)
  local arguments = string.format('keepjumps keeppatterns execute %q', arguments)
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_command(arguments)
  local lastline = vim.fn.line('$')
  if line > lastline then
    line = lastline
  end
  vim.api.nvim_win_set_cursor(0, { line, col })
end

M.Ranger = function()
  local status_ok, _ = pcall(require, 'toggleterm')
  if not status_ok then
    return vim.notify("toggleterm.nvim isn't installed!")
  end
  if vim.fn.executable('ranger') == 0 then
    return vim.notify("ranger isn't installed")
  end
  local ranger = require('toggleterm.terminal').Terminal:new({
    cmd = 'ranger',
    direction = 'float',
    on_open = function(term)
      vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    end,
  })
  ranger:toggle()
end

--> :lua changeheader()
-- This function is called with the BufWritePre event (autocmd)
-- and when I want to save a file I use ":update" which
-- only writes a buffer if it was modified
M.changeheader = function()
  -- We only can run this function if the file is modifiable
  if not vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), 'modifiable') then
    return
  end
  if vim.fn.line('$') >= 7 then
    os.setlocale('en_US.UTF-8') -- show Sun instead of dom (portuguese)
    time = os.date('%a, %d %b %Y %H:%M')
    M.preserve('sil! keepp keepj 1,7s/\\vlast (modified|change):\\zs.*/ ' .. time .. '/ei')
  end
end

M.choose_colors = function()
  local actions = require('telescope.actions')
  local actions_state = require('telescope.actions.state')
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local sorters = require('telescope.sorters')
  local dropdown = require('telescope.themes').get_dropdown()

  function enter(prompt_bufnr)
    local selected = actions_state.get_selected_entry()
    local cmd = 'colorscheme ' .. selected[1]
    vim.cmd(cmd)
    actions.close(prompt_bufnr)
  end

  function next_color(prompt_bufnr)
    actions.move_selection_next(prompt_bufnr)
    local selected = actions_state.get_selected_entry()
    local cmd = 'colorscheme ' .. selected[1]
    vim.cmd(cmd)
  end

  function prev_color(prompt_bufnr)
    actions.move_selection_previous(prompt_bufnr)
    local selected = actions_state.get_selected_entry()
    local cmd = 'colorscheme ' .. selected[1]
    vim.cmd(cmd)
  end

  -- local colors = vim.fn.getcompletion("", "color")

  local opts = {

    finder = finders.new_table({
      'gruvbox',
      'catppuccin',
      'material',
      'rose-pine',
      'nordfox',
      'nightfox',
      'monokai',
      'tokyonight',
    }),
    -- finder = finders.new_table(colors),
    sorter = sorters.get_generic_fuzzy_sorter({}),

    attach_mappings = function(prompt_bufnr, map)
      map('i', '<CR>', enter)
      map('i', '<C-j>', next_color)
      map('i', '<C-k>', prev_color)
      map('i', '<C-n>', next_color)
      map('i', '<C-p>', prev_color)
      return true
    end,
  }

  local colors = pickers.new(dropdown, opts)

  colors:find()
end

-- Append modeline at end of file.
-- source: https://github.com/rafi/vim-config/blob/master/lua/rafi/util/edit.lua
M.append_modeline = function()
  local modeline = string.format(
    'vim: set ts=%d sw=%d tw=%d %set :',
    vim.bo.tabstop,
    vim.bo.shiftwidth,
    vim.bo.textwidth,
    vim.bo.expandtab and '' or 'no'
  )
  modeline = string.gsub(vim.bo.commentstring, '%%s', modeline)
  vim.cmd('$pu_')
  vim.api.nvim_buf_set_lines(0, -1, -1, false, { modeline })
end

-- Go to newer/older buffer through jumplist.
---@param direction 1 | -1
M.jump_buffer = function(direction)
  local jumplist, curjump = unpack(vim.fn.getjumplist() or { 0, 0 })
  if #jumplist == 0 then
    return
  end
  local cur_buf = vim.api.nvim_get_current_buf()
  local jumpcmd = direction > 0 and '<C-i>' or '<C-o>'
  local searchrange = {}
  curjump = curjump + 1
  if direction > 0 then
    searchrange = vim.fn.range(curjump + 1, #jumplist)
  else
    searchrange = vim.fn.range(curjump - 1, 1, -1)
  end

  for _, i in ipairs(searchrange) do
    local nr = jumplist[i]['bufnr']
    if nr ~= cur_buf and vim.fn.bufname(nr):find('^%w+://') == nil then
      local n = tostring(math.abs(i - curjump))
      vim.notify('Executing ' .. jumpcmd .. ' ' .. n .. ' times')
      jumpcmd = vim.api.nvim_replace_termcodes(jumpcmd, true, true, true)
      vim.cmd.normal({ n .. jumpcmd, bang = true })
      break
    end
  end
end

return M

-- vim: set ts=2 sw=2 tw=78 et :
