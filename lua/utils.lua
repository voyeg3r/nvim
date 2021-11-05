local execute = vim.api.nvim_command
local vim = vim
local opt  = vim.opt   -- global
local g  = vim.g     -- global for let options
local wo = vim.wo    -- window local
local bo = vim.bo    -- buffer local
local fn = vim.fn    -- access vim functions
local cmd = vim.cmd  -- vim commands
local api = vim.api  -- access vim api

local M = {}

-- https://vi.stackexchange.com/questions/31206
M.flash_cursorline = function()
    vim.opt.cursorline = true
    vim.cmd([[hi CursorLine guifg=#000000 guibg=#ffffff]])
    vim.fn.timer_start(200, function()
        vim.cmd([[hi CursorLine guifg=NONE guibg=NONE]])
        vim.opt.cursorline = false
    end)
end

-- M.flash_cursorline = function()
--    vim.opt.cursorline = true
--    vim.fn.timer_start(200, function()
--         vim.opt.cursorline = false
--     end)
--     vim.opt.cursorline = false
-- end
--
M.squeeze_blank_lines = function()
    -- references: https://vi.stackexchange.com/posts/26304/revisions
    local old_query = vim.fn.getreg('/')    -- save search register
    M.preserve('sil! 1,.s/^\\n\\{2,}/\\r/gn') -- set current search count number
    local result = vim.fn.searchcount({maxcount = 1000, timeout = 500}).current
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    M.preserve('sil! keepp keepj %s/^\\n\\{2,}/\\r/ge')
    M.preserve('sil! keepp keepj %s/\\v($\\n\\s*)+%$/\\r/e')
    if result > 0 then
        vim.api.nvim_win_set_cursor({0}, {(line - result), col})
    end
    vim.fn.setreg('/', old_query)           -- restore search register
end

-- https://neovim.discourse.group/t/reload-init-lua-and-all-require-d-scripts/971/11
function M.ReloadConfig()
    local hls_status = vim.v.hlsearch
    for name,_ in pairs(package.loaded) do
        if name:match('^cnull') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    if hls_status == 0 then
        vim.opt.hlsearch = false
    end
end

function M.preserve(arguments)
    local arguments = string.format('keepjumps keeppatterns execute %q', arguments)
    -- local original_cursor = vim.fn.winsaveview()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_command(arguments)
	local lastline = vim.fn.line('$')
    -- vim.fn.winrestview(original_cursor)
	if line > lastline then
		line = lastline
	end
	vim.api.nvim_win_set_cursor({0}, {line , col})
end

--> :lua changeheader()
-- This function is called with the BufWritePre event (autocmd)
-- and when I want to save a file I use ":update" which
-- only writes a buffer if it was modified
M.changeheader = function()
    if (vim.fn.line('$') >= 7) then
        time = os.date("%a, %d %b %Y %H:%M")
        M.preserve('sil! keepp keepj 1,7s/\\vlast (modified|change):\\zs.*/ ' .. time .. '/ei')
    end
end

return M

-- vim.api.nvim_set_keymap('n', '<Leader>vs', '<Cmd>lua ReloadConfig()<CR>', { silent = true, noremap = true })
-- vim.cmd('command! ReloadConfig lua ReloadConfig()')
