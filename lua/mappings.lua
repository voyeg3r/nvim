-- map helper
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>x', ':wsh | up | bd!<cr>', {silent = true})
map('n', '<leader>w', ':bw!<cr>', {silent = true})

-- Reload config
-- map('n', '<c-m-r>', '<Cmd>lua ReloadConfig()<CR>')

-- salvar com <F9>
map('n', '<F9>', '<cmd>update<cr>')

map('n', '<leader>p', "'`[' . strpart(getregtype(), 0, 1) . '`]'" , {expr = true})

-- It adds motions like 25j and 30k to the jump list, so you can cycle
-- through them with control-o and control-i.
-- source: https://www.vi-improved.org/vim-tips/
map('n', 'j', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], {expr = true})
map('n', 'k', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], {expr = true})

map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '<c-o>', '<c-o>zz')
map('n', '<c-i>', '<c-i>zz')
map('n', '}', '}zz')
map('n', '{', '{zz')

-- Reselect visual when indenting
map('x' , '>', '>gv')
map('x' , '<', '<gv')

map('n', '<leader>v', '<cmd>e $MYVIMRC<cr>')
map('n', 'Y', 'y$')
map('n', '<F2>', '<cmd>NvimTreeToggle<CR>')
map('n', '<C-l>', [[ (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n" <BAR> redraw<CR>]], {silent = true, expr = true} )

-- shortcuts to jump in the command line
map('c', '<C-a>', '<home>')
map('c', '<C-e>', '<end>')

map('i', '<s-<cr>', '<c-o>o')
map('i', '<c-<cr>', '<c-o>O')

map('n', 'ç', ':')

-- Make windows to be basically the same size
map('n', '<leader>=', '<c-w-=>')

-- -- line text-objects
map('x', 'al', ':<C-u>norm!0v$<cr>')
map('x', 'il', ':<C-u>norm!_vg_<cr>')
map('o', 'al', ':norm val<cr>')
map('o', 'il', ':norm vil<cr>')

--Add move line shortcuts
map('n', '<A-j>', ':m .+1<CR>==')
map('n', '<A-k>', ':m .-2<CR>==')
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
map('v', '<A-j>', ':m \'>+1<CR>gv=gv')
map('v', '<A-k>', ':m \'<-2<CR>gv=gv')

map('n', '<leader>d', '<cmd>lua require("utils").squeeze_blank_lines()<cr>')

-- telescope mappings
map('n', '<leader>o', ':lua require("telescope.builtin").oldfiles()<cr>')
-- cd ~/.dotfiles/wiki | Telescope find_files
map('n', '<c-p>', [[<cmd>lua require("telescope.builtin").find_files{cwd = "~/.dotfiles"}<cr>]], {silent = true})
map('n', '<F8>', [[<cmd>lua require("telescope.builtin").find_files{cwd = "~/.config"}<cr>]], {silent = true})
-- map('n', '<F8>', [[<cmd>lua require("telescope.builtin").find_files{cwd = "~/.config/nvim"}<cr>]], {silent = true})
map('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { silent = true})
map('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], {  silent = true})
map('n', '<leader>l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], {  silent = true})
-- map('n', '<leader>t', [[<cmd>lua require('telescope.builtin').tags()<cr>]], {  silent = true})
map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], {  silent = true})
map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], {  silent = true})
map('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep{cwd = "~/.dotfiles/wiki"}<cr>]], {  silent = true})
-- map('n', '<leader>o', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]], {  silent = true})
map('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], {  silent = true})
map('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], {  silent = true})
map('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], {  silent = true})
map('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], {  silent = true})
-- end of telescope mappings

-- mappings for persistence plugin
-- restore the session for the current directory
map("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]])

-- restore the last session
map("n", "<F5>", [[<cmd>lua require("persistence").load({ last = true })<cr>]])

-- stop Persistence => session won't be saved on exit
map("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]])

-- I do not enjoy accidentally nuking an entire line and not being able to undo the action :)
-- Incidentally, Vim has the <C-u> mapping in defaults.vim
map('i', '<C-u>', '<C-g>u<C-u>', {noremap = true})
map('i', '<C-w>', '<C-g>u<C-w>', {noremap = true})

map('n', '<c-m-c>', ':ColorizerToggle')
map('n', '<c-m-l', ':set list!<cr>')

-- -- vim-vsnip
-- -- Expand
-- map("i", "<c-j>" , [[vsnip#expandable()  ? '<Plug>(vsnip-expand)'  : '<C-j>']], { expr = true})
-- map("s", "<c-j>" , [[vsnip#expandable()  ? '<Plug>(vsnip-expand)'  : '<C-j>']], { expr = true})
--
-- -- Expand or jump
-- map('i',  "<c-m-l>",  [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']], {expr = true})
-- map('s',  "<c-m-l>",  [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']], {expr = true})
--
-- -- Jump forward or backward
-- map("i",  "<Tab>" ,  [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)'  : '<Tab>']], { expr = true })
-- map("s",  "<Tab>" ,  [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)'  : '<Tab>']], { expr = true })
-- map("i",  "<S-Tab>", [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'  : '<S-Tab>']], { expr = true })
-- map("s",  "<S-Tab>", [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'  : '<S-Tab>']], { expr = true })
--
