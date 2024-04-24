-- File: ~/.config/nvim/luasnip/lua.lua
-- Last Change: Mon, Jan 2024/01/08 - 20:54:58

local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local dl = require("luasnip.extras").dynamic_lambda
local l = require("luasnip.extras").lambda

-- some shorthands...
local s = ls.snippet
local n = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local dn = ls.dynamic_node

ls.config.set_config({
  history = true,
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 200,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
})

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)

local function get_line_iter(str)
  if str:sub(-1) ~= "\n" then
    str = str .. "\n"
  end

  return str:gmatch("(.-)\n")
end

local function not_comment()
  local parser = vim.treesitter.get_parser()
  local root = parser:parse()[1]
  local cursor_node = vim.treesitter.get_node_at_cursor()
  return not cursor_node:type() == "comment"
end

local function box_trim_lines(str)
  local new_str = ""

  for line in get_line_iter(str) do
    line = line:gsub("^%s+", "")
    line = string.gsub(line, "%s+$", "")
    new_str = new_str .. "\n" .. line
  end

  return new_str
end

-- @no params return full filename
local return_filename = function()
  local filename = vim.fn.fnamemodify(vim.fn.expand("%"), ":p")
  local home_dir = vim.fn.expand("~")
  if filename:sub(1, #home_dir) == home_dir then
    filename = "~/" .. filename:sub(#home_dir + 2)
  end
  return filename
end

-- @no params return short filename as string
local short_filename = function()
  return vim.fn.fnamemodify(vim.fn.expand("%"), ":t")
end

local date = function()
  return { os.date("%Y-%m-%d") }
end

local fulldate = function()
  return { os.date("%a, %b %Y/%m/%d - %H:%M:%S") }
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
  return { vim.fn.expand("%:p") }
end

local clipboard = function()
  return { vim.fn.getreg("+") }
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, _, command)
  local file = io.popen(command, "r")
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end

local function get_port_snip(args)
  if #args < 1 and not args[1][1] then
    return n(nil, t("hello world"))
  end

  local type = args[1][1]
  local indent = "      "

  if type == "NodePort" or type == "LoadBalancer" then
    return n(
      nil,
      fmt(
        box_trim_lines([[
        - port: {}
          {}targetPort: {}
          {}nodePort: {}
        ]]),
        {
          i(1, "30000"),
          indent,
          i(2, "80"),
          indent,
          i(3, "30000"),
        }
      )
    )
  end

  if type == "ClusterIP" then
    return n(
      nil,
      fmt(
        [[
        - port: {}
        {}targetPort: {}
        ]],
        {
          i(1, "30000"),
          indent,
          i(2, "80"),
        }
      )
    )
  end
end

ls.add_snippets(nil, {

  lua = {
    s("shebang", {
      t({ "#!/usr/bin/lua", "", "" }),
      i(0),
    }),
    s({
      trig = "_skel",
      namr = "File_skeleton",
      dscr = "File header (dynamic)",
      -- snippetType = 'autosnippet',
    }, {
      t({ "-- File: " }),
      f(return_filename, {}),
      t({ "", "-- Last Change: " }),
      f(fulldate, {}),
      t({ "", "-- Author: " }),
      i(1, "Sergio Araujo"),
      t({ "", "" }),
      t({ "", "" }),
      i(0),
    }),

    s("stemplate", {
      t({
        "local ls = require 'luasnip'",
        "ls = ls,",
        "fmt = require('luasnip.extras.fmt').fmt,",
        "rep = require('luasnip.extras').rep,",
        "local helpers = require('core.luasnip-helper-funcs')",
        "local get_visual = helpers.get_visual",
        "",
        "-- some shorthands...",
        "s  = ls.snippet,",
        "sn = ls.snippet_node,",
        "n  = ls.snippet_node,",
        "t  = ls.text_node,",
        "i  = ls.insert_node,",
        "f  = ls.function_node,",
        "c  = ls.choice_node,",
        "d  = ls.dynamic_node,",
        "",
      }),
      i(0),
    }),

    s(
      {
        trig = "req",
        namr = "Smart_require_regex",
        dscr = "Smart require using regex",
        priority = 2000,
      },
      fmt('local {} = require("{}")', {
        l(l._1:match("[^.]*$"):gsub("[^%a]+", "_"), 1),
        i(1, "module"),
      })
    ),

    s({
      trig = "fulldate",
      namr = "inser_full_date",
      dscr = "Triggers full date",
      snippetType = "autosnippet",
    }, f(fulldate, {})),

    s({
      trig = "ffname",
      namr = "inser_file_name",
      dscr = "Triggers full file name",
      snippetType = "autosnippet",
    }, {
      f(return_filename, {}),
    }),

    s({
      trig = "sname",
      namr = "short_file_name",
      dscr = "Triggers short file name",
      snippetType = "autosnippet",
    }, {
      f(short_filename, { space = true }),
    }),

    -- local user_cmd = vim.api.nvim_create_user_command
    s(
      {
        trig = "cmd",
        namr = "user_defined_cmd",
        dscr = "User command",
      },
      fmt(
        [[user_cmd(
    '<>',
    '<>',
    { desc = "<>", nargs = 0, bang = true }
    )
    ]],
        {
          i(1, "cmd-name"),
          i(2, "action"),
          i(3, "desc"),
        },
        { delimiters = "<>" }
      )
    ),

    s(
      {
        trig = "map",
        namr = "map_helper",
        dscr = "Easy map creation",
        priority = 2000,
      },
      fmt(
        [[
      map(
         '<>',
         '<>',
         '<>',
         { desc = '<>', silent = true }
      )
      ]],
        {
          i(1, "n"),
          i(2, "lhs"),
          i(3, "rhs"),
          i(4, "desc"),
        },
        { delimiters = "<>" }
      )
    ),

    s(
      { trig = "sreq", namr = "Smart_require_tjdevris", dscr = "Smart require by TJdevris" },
      fmt([[local {} = require "{}"]], {
        f(function(import_name)
          local parts = vim.split(import_name[1][1], ".", true)
          return parts[#parts] or ""
        end, { 1 }),
        i(1),
      })
    ),

    s(
      { trig = "preq", namr = "protected_call", dscr = "Protected call" },
      fmt('local {1}_ok, {1} = pcall(require, "{}")\nif not {1}_ok then return end', {
        l(l._1:match("[^.]*$"):gsub("[^%a]+", "_"), 1),
        i(1, "module"),
      })
    ),

    s("func", {
      t("function("),
      i(1),
      t({ ")", "\t" }),
      i(2),
      t({ "", "end", "" }),
      i(0),
    }),
    s("forp", {
      t("for "),
      i(1, "k"),
      t(", "),
      i(2, "v"),
      t(" in pairs("),
      i(3, "table"),
      t({ ") do", "\t" }),
      i(4),
      t({ "", "end", "" }),
      i(0),
    }),
    s("fori", {
      t("for "),
      i(1, "k"),
      t(", "),
      i(2, "v"),
      t(" in ipairs("),
      i(3, "table"),
      t({ ") do", "\t" }),
      i(4),
      t({ "", "end", "" }),
      i(0),
    }),
    s(
      {
        trig = "if",
        -- snippetType = 'autosnippet',
        priority = 2000,
        -- wordTrig = false,
      },
      fmt(
        [[
      if {} then
        {}
      end
        ]],
        { i(1), i(2) }
      )
    ),
    -- snip({
    --     trig = 'if',
    --     snippetType = 'autosnippet',
    --     condition = function()
    --       return not vim.api.nvim_get_current_line():match('^%s*--.*$')
    --     end
    --   },
    --   fmt([[
    --     if {} then
    --       {}
    --     end
    --     ]], {
    --     i(1, "test"), i(2, "action")
    --   })),
    s("M", {
      t({ "local M = {}", "", "" }),
      i(0),
      t({ "", "", "return M" }),
    }),
  },
})
