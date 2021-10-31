-- nvim-autopairs settings

-- require('nvim-autopairs').setup({
--   disable_filetype = { "TelescopePrompt" , "vim" },
-- })

-- nvim-autopairs plugin settings
-- you need setup cmp first put this after cmp.setup()
-- use 'windwp/nvim-autopairs'
require('nvim-autopairs').setup{
	check_ts = true,
    enable_check_bracket_line = false,
	fast_wrap = {},
    disable_filetype = { "TelescopePrompt" , "vim" },
}
require("cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true -- automatically select the first item
})

