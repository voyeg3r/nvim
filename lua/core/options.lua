-- Filename: options.lua
-- Last Change: Tue, 11 Jul 2023 - 16:23

local vim = vim
local opt = vim.opt
local g = vim.g

if vim.fn.executable('nvr') == 1 then
  vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

-- If sudo, disable vim swap/backup/undo/shada writing
local USER = vim.env.USER or ''
local SUDO_USER = vim.env.SUDO_USER or ''
if
  SUDO_USER ~= ''
  and USER ~= SUDO_USER
  and vim.env.HOME ~= vim.fn.expand('~' .. USER, true)
  and vim.env.HOME == vim.fn.expand('~' .. SUDO_USER, true)
then
  vim.opt_global.modeline = false
  vim.opt_global.undofile = false
  vim.opt_global.swapfile = false
  vim.opt_global.backup = false
  vim.opt_global.writebackup = false
  vim.opt_global.shadafile = 'NONE'
end

-- https://vi.stackexchange.com/a/5318/7339
vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20
vim.g.python3_host_prog = vim.loop.os_homedir() .. '/.virtualenvs/neovim/bin/python3'

vim.g.have_nerd_font = true -- nerd font

-- Disable some default providers
for _, provider in ipairs({ 'node', 'perl', 'python3', 'ruby' }) do
  vim.g['loaded_' .. provider .. '_provider'] = 0
end

-- Enable filetype.lua
vim.g.do_filetype_lua = 1
--vim.g.did_load_filetypes = 0 -- disable filetype.vim

vim.g.markdown_fenced_languages = {
  'html',
  'javascript',
  'typescript',
  'css',
  'scss',
  'lua',
  'vim',
  'sh',
}

vim.diagnostic.config({
  float = { border = 'rounded' }, -- add border to diagnostic popups
})

local options = {
  --keywordprg = ':help',
  equalalways = true,
  -- winbar = '%=%m %F',
  nrformats = { 'alpha', 'octal', 'hex' },
  -- regexpengine = 1,
  virtualedit = 'block',
  modelines = 5,
  modelineexpr = false,
  modeline = true,
  cursorline = true,
  cursorcolumn = false,
  splitright = true,
  splitbelow = true,
  smartcase = true,
  hlsearch = true,
  ignorecase = true,
  incsearch = true,
  inccommand = 'nosplit',
  hidden = true,
  autoindent = true,
  termguicolors = true,
  showmode = false,
  showmatch = true,
  matchtime = 2,
  shortmess = vim.opt.shortmess:append({ C = true }),
  wildmode = 'longest:full,full',
  completeopt = 'menu,menuone,noinsert',
  number = true,
  linebreak = true,
  joinspaces = false,
  -- timeoutlen = 500,
  ttimeoutlen = 10, -- https://vi.stackexchange.com/a/4471/7339
  path = vim.opt.path + '.,**',
  isfname = vim.opt.isfname:append('@-@'),
  autochdir = true,
  relativenumber = true,
  numberwidth = 2,
  shada = "!,'50,<50,s10,h,r/tmp",
  expandtab = true,
  smarttab = true,
  smartindent = true,
  shiftround = true,
  shiftwidth = 2,
  tabstop = 2,
  foldenable = false,
  foldlevel = 99,
  foldlevelstart = 99,
  foldcolumn = '1',
  undodir = os.getenv('HOME') .. '/.vim/undodir',
  undofile = true,
  showtabline = 0,
  mouse = 'a',
  mousescroll = 'ver:2,hor:6',
  scrolloff = 3,
  sidescrolloff = 3,
  wrap = true,
  listchars = {
    nbsp = '⦸',
    extends = '»',
    precedes = '«',
    eol = '↲',
    tab = '▸ ',
    trail = '•',
  },
  -- lazyredraw = true, -- noice conflict
  updatetime = 250,
  laststatus = 3,
  confirm = false,
  conceallevel = 3,
  cmdheight = 0,
  -- filetype = 'on', -- handled by filetype = 'on' --login
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

if vim.fn.has('nvim-0.10') == 1 then
  opt.smoothscroll = true
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
else
  vim.opt.foldmethod = 'indent'
end

if vim.fn.executable('rg') then
  -- if ripgrep installed, use that as a grepper
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
  vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end
--lua require("notify")("install ripgrep!")

if vim.fn.executable('prettier') then
  opt.formatprg = 'prettier --stdin-filepath=%'
end
--lua require("notify")("Install prettier formater!")

opt.formatoptions = 'l'
opt.formatoptions = opt.formatoptions
  - 'a' -- Auto formatting is BAD.
  - 't' -- Don't auto format my code. I got linters for that.
  + 'c' -- In general, I like it when comments respect textwidth
  - 'o' -- O and o, don't continue comments
  + 'r' -- But do continue when pressing enter.
  + 'n' -- Indent past the formatlistpat, not underneath it.
  + 'j' -- Auto-remove comments if possible.
  - '2' -- I'm not in gradeschool anymore

opt.guicursor = {
  'n-v:block',
  'i-c-ci-ve:ver25',
  'r-cr:hor20',
  'o:hor50',
  'i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
  'sm:block-blinkwait175-blinkoff150-blinkon175',
}

-- window-local options
local window_options = {
  numberwidth = 2,
  number = true,
  relativenumber = true,
  linebreak = true,
  -- cursorline = true,
  foldenable = false,
}

for k, v in pairs(window_options) do
  vim.opt_local[k] = v
end
