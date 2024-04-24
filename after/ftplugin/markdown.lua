-- Filename: ~/.config/nvim/after/ftplugin/markdown.lua
-- Last Change: Sun, 26 Nov 2023 12:52:29

-- local opts = { noremap = true, silent = true }
-- vim.api.nvim_buf_set_keymap(0, 'n', 'j', 'gj', opts)
-- vim.api.nvim_buf_set_keymap(0, 'n', 'k', 'gk', opts)

vim.opt_local.number = false
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = ''
vim.opt_local.relativenumber = false
vim.opt_local.list = false
vim.g['loaded_spellfile_plugin'] = 0
vim.opt_local.spell = false
vim.bo.spelllang = 'en'
vim.bo.textwidth = 80
vim.bo.filetype = 'markdown'
vim.opt_local.wrap = true
vim.opt_local.suffixesadd:prepend('.md')

vim.cmd([[highlight MinhasNotas ctermbg=Yellow ctermfg=red guibg=Yellow guifg=red]])
vim.cmd([[match MinhasNotas /NOTE:/]])

-- -- source: https://neovim.discourse.group/t/how-can-i-create-a-keymap-using-treesitter-to-jump-to-the-next-markdown-header/4579/4
-- local query = vim.treesitter.query.parse('markdown', '((atx_heading) @header)')
-- -- NOTE: ]] jumps are now done through treesitter
-- vim.keymap.set(
--   'n',
--   '<leader><right>',
--   function()
--     local root = vim.treesitter.get_parser():parse()[1]:root()
--     local _, node, _ = query:iter_captures(root, 0, vim.fn.line '.', -1)()
--     if not node then return end
--     require 'nvim-treesitter.ts_utils'.goto_node(node)
--     vim.cmd('normal zt')
--     require('core.utils').flash_cursorline()
--   end,
--   {
--     silent = true,
--     buffer = 0,
--     desc = 'Ft map: Jump to next md heading'
--   }
-- )

-- local query = vim.treesitter.query.parse('markdown', '((atx_heading) @header)')
-- vim.keymap.set('n', '<leader><left>', function()
--     local root = vim.treesitter.get_parser():parse()[1]:root()
--     if vim.fn.line '.' == 1 then return end
--     local node
--     for _, n, _ in query:iter_captures(root, 0, 0, vim.fn.line '.' - 1) do
--       node = n
--     end
--     if not node then return end
--     require 'nvim-treesitter.ts_utils'.goto_node(node)
--     vim.cmd('normal zt')
--     require('core.utils').flash_cursorline()
--   end,
--   {
--     silent = true,
--     buffer = 0,
--     desc = 'Ft map: Jump to previous md heading'
--   }
-- )

-- local function is_in_list()
--   return vim.fn.match(vim.fn.getline '.', '\\s*[*\\-+]\\s') ~= -1
-- end

local function is_in_list()
  local current_line = vim.api.nvim_get_current_line()
  return current_line:match('^%s*[%*-+]%s') ~= nil
end

local function has_checkbox()
  local current_line = vim.api.nvim_get_current_line()
  return current_line:match('%s*[%*-+]%s%[[ x]%]') ~= nil
end

local function list_prefix()
  local line = vim.api.nvim_get_current_line()
  local list_char = line:gsub("^%s*([-%*+] )(.*)",
    function(prefix, rest)
      return prefix
    end)
  return list_char
end

local function is_in_num_list()
  local current_line = vim.api.nvim_get_current_line()
  return current_line:match('^%s*%d+%.%s') ~= nil
end

vim.keymap.set('i', '<cr>', function()
  if is_in_list() then
    local prefix = list_prefix()
    return has_checkbox() and '<cr>' .. prefix .. '[ ] ' or '<cr>' .. prefix
  elseif is_in_num_list() then
    local line = vim.api.nvim_get_current_line()
    local modified_line = line:gsub("^%s*(%d+)%.%s.*$",
      function(numb)
        numb = tonumber(numb) + 1
        return tostring(numb)
      end)
    return '<cr>' .. modified_line .. '. '
  else
    return '<cr>'
  end
end, {
  buffer = true,
  expr = true,
})

vim.keymap.set(
  'n',
  'o',
  function()
    if is_in_list() then
      local prefix = list_prefix()
      return has_checkbox() and 'o' .. prefix .. '[ ] ' or 'o' .. prefix
  elseif is_in_num_list() then
    local line = vim.api.nvim_get_current_line()
    local modified_line = line:gsub("^%s*(%d+)%.%s.*$",
      function(numb)
        numb = tonumber(numb) + 1
        return tostring(numb)
      end)
    return 'o' .. modified_line .. '. '
    else
      return 'o'
    end
  end, {
    buffer = true,
    expr = true,
  })

vim.keymap.set('n', 'O', function()
  if is_in_list() then
    local prefix = list_prefix()
    return has_checkbox() and 'O' .. prefix .. '[ ] ' or 'O' .. prefix
  elseif is_in_num_list() then
    local line = vim.api.nvim_get_current_line()
    local modified_line = line:gsub("^%s*(%d+)%.%s.*$",
      function(numb)
        numb = tonumber(numb) + 1
        return tostring(numb)
      end)
    return 'O' .. modified_line .. '. '
  else
    return 'O'
  end
end, {
  buffer = true,
  expr = true,
})

-- -- Disabled because we have Ctrl-t
-- vim.keymap.set('i', '<tab>', function()
--   if is_in_list() then
--     return '<esc>>>A'
--   else
--     return '<tab>'
--   end
-- end, {
--   buffer = true,
--   expr = true,
-- })

-- -- Disabled because we have Ctrl-d
-- vim.keymap.set('i', '<S-Tab>', function()
--   if is_in_list() then
--     return '<esc><<A'
--   else
--     return '<tab>'
--   end
-- end, {
--     buffer = true,
--     expr = true,
--   })

-- inspiration from this thead:
-- https://www.reddit.com/r/neovim/comments/10s5oou
vim.keymap.set(
  { 'n', 'i' },
  '<leader>tt',
  function()
    local line = vim.api.nvim_get_current_line()
    local modified_line = line:gsub("([-%*+] %[)(.)(%])",
      function(prefix, checkbox, postfix)
        checkbox = (checkbox == " ") and "x" or " "
        return prefix .. checkbox .. postfix
      end)
    vim.api.nvim_set_current_line(modified_line)
  end,
  {
    desc = 'Ftplugin - Toggle checkboxes',
    buffer = true,
  }
)
