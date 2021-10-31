-- autocommands

--- This function is taken from https://github.com/norcalli/nvim_utils
function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

local autocmds = {
    reload_vimrc = {
        -- Reload vim config automatically
        -- {"BufWritePost",[[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]]};
        {"BufWritePre", "$MYVIMRC", "lua require('utils').ReloadConfig()"};
    };
  -- change_header = {
		-- {"BufWritePre", "*", "lua require('tools').changeheader()"};
--   };
    packer = {
        { "BufWritePost", "plugins.lua", "PackerCompile" };
    };
    terminal_job = {
        { "TermOpen", "*", [[tnoremap <buffer> <Esc> <c-\><c-n>]] };
        { "TermOpen", "*", [[tnoremap <buffer> <leader>x <c-\><c-n>:bd!<cr>]] };
        { "TermOpen", "*", [[tnoremap <expr> <A-r> '<c-\><c-n>"'.nr2char(getchar()).'pi' ]]};
        { "TermOpen", "*", "startinsert" };
        { "TermOpen", "*", [[nnoremap <buffer> <C-c> i<C-c>]]};
        { "TermOpen", "*", "setlocal listchars= nonumber norelativenumber" };
    };
    restore_cursor = {
        { 'BufRead', '*', [[call setpos(".", getpos("'\""))]] };
    };
    -- save_shada = {
    --     -- { "VimLeave", "*", "wshada!"};
    --     { "CursorHold", "*", [[rshada|wshada]]};
    -- };
    resize_windows_proportionally = {
        { "VimResized", "*", ":wincmd =" };
    };
    toggle_search_highlighting = {
        { "InsertEnter", "*", "setlocal nohlsearch" };
    };
    lua_highlight = {
        { "TextYankPost", "*", [[silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=400}]] };
    };
    auto_working_directory = {
        {"BufEnter", "*", "silent! lcd %:p:h"}
    };
    clean_trailing_spaces = {
        {"BufWritePre", "*", [[lua require("utils").preserve('%s/\\s\\+$//ge')]]}
    };
    -- ansi_esc_log = {
    --     { "BufEnter", "*.log", ":AnsiEsc" };
    -- };
    -- flash_cursor_line = {
    --     { "WinEnter", "*", "lua require('tools').flash_cursor_line()" };
    -- };
	-- attatch_colorizer = {
	-- 	-- {BufReadPost *.conf setl ft=conf};
	-- 	{"BufReadPost", "config", "setl ft=conf"};
	-- 	{"FileType", "conf", "ColorizerAttachToBuffer<CR>"};
	-- };
}

nvim_create_augroups(autocmds)
-- autocommands END


