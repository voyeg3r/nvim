-- with packer you can do
-- use 'tlvince/securemodelines'
vim.g.secure_modelines_verbose = true
vim.g.secure_modelines_leave_modeline = 1
vim.g.secure_modelines_allowed_items = {
    "textwidth",   "tw", "spell",       "nospell",
    "softtabstop", "sts", "tabstop",     "ts",
    "shiftwidth",  "sw", "expandtab",   "et",   "noexpandtab", "noet",
    "filetype",    "ft", "textwidth",   "tw",
    "conceallevel","cole", "foldmethod",  "fdm",
    "readonly",    "ro",   "noreadonly", "noro",
    "rightleft",   "rl",   "norightleft", "norl", 
    "foldenable",   "fen",  "nofen",
	"commentstring", "cms"
}
