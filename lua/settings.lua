local opt = vim.opt

vim.cmd([[cnoreab cls Cls]])
vim.cmd([[command! Cls lua require("utils").preserve('%s/\\s\\+$//ge')]])
vim.cmd([[command! Reindent lua require('utils').preserve("sil keepj normal! gg=G")]])
vim.cmd([[command! BufOnly lua require('utils').preserve("silent! %bd|e#|bd#")]])

vim.cmd('command! ReloadConfig lua require("utils").ReloadConfig()')

vim.cmd([[inoreab Fname <c-r>=expand("%:p")<cr>]])
vim.cmd([[inoreab fname <c-r>=expand("%:t")<cr>]])
vim.cmd([[cnoreab cls Cls]])
vim.cmd([[command! Cls lua require("utils").preserve('%s/\\s\\+$//ge')]])
vim.cmd([[command! Reindent lua require('utils').preserve("sil keepj normal! gg=G")]])
vim.cmd([[command! BufOnly lua require('utils').preserve("silent! %bd|e#|bd#")]])

vim.cmd([[highlight RedundantSpaces ctermbg=red guibg=red ]])
vim.cmd([[match RedundantSpaces /\s\+$/]])

-- vim.cmd([[cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep']]
-- vim.cmd([[cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep']]
-- vim.cmd([[cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep']]
-- vim.cmd([[cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep']]


-- ulstisnips spend time finding python provider
-- https://github.com/neovim/neovim/issues/5702#issuecomment-264440944
vim.g.loaded_python_provider = 1
vim.g.python_host_skip_check=1
vim.g.python_host_prog = '/bin/python2'
vim.g.python3_host_skip_check=1
vim.g.python3_host_prog = '/bin/python3'

-- It seems like I am not beein able to load this option
-- in the ~/.config/nvim/lua/plugins/config/blankline.lua
-- vim.g.indent_blankline_show_first_indent_level = false

-- loading luasnip
-- require("luasnip/loaders/from_vscode").load()
require("luasnip.loaders.from_vscode").lazy_load(opts)
vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.g.mapleader = ','
opt.showbreak = "↳  "
opt.listchars = { eol = '↲', tab = '▶ ', trail = '•', precedes = "«", extends = "»", nbsp = "␣", space = "." }

--Do not save when switching buffers
opt.hidden = true
opt.path = vim.opt.path + '~,.,**'
vim.o.switchbuf = 'useopen' -- use an already open window if possible
opt.iskeyword = vim.opt.iskeyword + '-'

-- Ignore compiled files
opt.wildignore = { ".git", ".hg", ".svn", "*.pyc", "*.o", "*.out", "*.jpg", "*.jpeg", "*.png", "*.gif", "*.zip" }
opt.wildignore = opt.wildignore + { "**/node_modules/**", "**/bower_modules/**",  "__pycache__", "*~", "*.DS_Store" }

-- opt.wildmode = { "longest", "list", "full" }
opt.wildmode = {"full", "list", "full"}


opt.cmdheight = 1 -- Height of the command bar
opt.inccommand = 'nosplit'
opt.showmode = false
opt.timeoutlen = 300

-- command menu settings
opt.pumheight = 10
opt.pumblend = 15

-- Enable mouse
opt.mouse = "a"

vim.g.nojoinspaces = true

--Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true
opt.wildignorecase = true
opt.scrolloff = 3
opt.incsearch = true
opt.lazyredraw = true
opt.termguicolors = true
opt.showmatch = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- buffer-local options
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.cursorline = false
vim.wo.foldenable = false
vim.bo.expandtab = true
vim.opt.shiftround = true
vim.bo.expandtab = true

opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

--Decrease update time
opt.updatetime = 250
vim.wo.signcolumn="yes"

--Set colorscheme (order is important here)
opt.termguicolors = true

--Add map to enter paste mode
opt.pastetoggle="<F3>"

-- Change preview window location
vim.g.splitbelow = true

if vim.fn.executable("rg") then
    -- if ripgrep installed, use that as a grepper
    vim.opt.grepprg = "rg --vimgrep --no-heading"
    vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

-- set fillchars=eob:~
opt.fillchars = { eob = "~" }
