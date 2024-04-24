-- Filename: snippets.lua
-- Last Change: Sun, 29 Oct 2023 - 13:11

local ls = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep
local dl = require('luasnip.extras').dynamic_lambda
local l = require('luasnip.extras').lambda

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.config.set_config {
  history = true,
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 200,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = false,
  store_selection_keys = '<Tab>',
}

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)

local function get_line_iter(str)
  if str:sub(-1) ~= '\n' then
    str = str .. '\n'
  end

  return str:gmatch('(.-)\n')
end
local function box_trim_lines(str)
  local new_str = ''

  for line in get_line_iter(str) do
    line = line:gsub('^%s+', '')
    line = string.gsub(line, '%s+$', '')
    new_str = new_str .. '\n' .. line
  end

  return new_str
end

local return_filename = function()
  return vim.fn.fnamemodify(vim.fn.expand('%'), ':p')
end

local date = function()
  return { os.date('%Y-%m-%d') }
end

local fulldate = function()
  return { os.date('%a, %b %Y/%m/%d - %H:%M:%S') }
end

-- lua print(os.date("%a, %b %Y/%m/%d - %H:%M:%S"))

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local filename = function()
  return { vim.fn.expand('%:p') }
end

local clipboard = function()
  return { vim.fn.getreg('+') }
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, _, command)
  local file = io.popen(command, 'r')
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end

local function get_port_snip(args)
  if #args < 1 and not args[1][1] then
    return node(nil, text('hello world'))
  end

  local type = args[1][1]
  local indent = '      '

  if type == 'NodePort' or type == 'LoadBalancer' then
    return node(
      nil,
      fmt(
        box_trim_lines([[
        - port: {}
          {}targetPort: {}
          {}nodePort: {}
        ]]),
        {
          insert(1, '30000'),
          indent,
          insert(2, '80'),
          indent,
          insert(3, '30000'),
        }
      )
    )
  end

  if type == 'ClusterIP' then
    return node(
      nil,
      fmt(
        [[
        - port: {}
        {}targetPort: {}
        ]],
        {
          insert(1, '30000'),
          indent,
          insert(2, '80'),
        }
      )
    )
  end
end

ls.add_snippets(nil, {
  
  python = {
    snip('shebang', {
      text { '#!/usr/bin/env python', '' },
      insert(0),
    }),
  },
  
})
