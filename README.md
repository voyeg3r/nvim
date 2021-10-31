Modular neovim configuration

    nvim
     ├── init.lua    ............... main config file
     ├── lua         ............... folder with all config files
     │   ├── autocmd.lua
     │   ├── mappings.lua
     │   ├── plugins
     │   │   ├── config
     │   │   │   ├── autopairs.lua
     │   │   │   ├── blankline.lua
     │   │   │   ├── buftabline.lua
     │   │   │   ├── cmp.lua
     │   │   │   ├── cmp.lua-backup
     │   │   │   ├── cmp.lua-backup2
     │   │   │   ├── lspconfig.lua
     │   │   │   ├── lspinstall.lua
     │   │   │   ├── lspkind_icons.lua
     │   │   │   ├── lspkind.lua
     │   │   │   ├── others.lua
     │   │   │   ├── securemodelines.lua
     │   │   │   └── telescope.lua
     │   │   └── init.lua
     │   ├── settings.lua
     │   └── utils.lua
     └── README.md  (this file)

Before install this settings backup your currnt config:

    cp ~/.config/nvim{,-backup}

Now run this command:

    rm -rf ~/.config/nvim
    rm -rf ~/.cache/nvim
    rm -rf ~/.local/share/nvim

If you have the command trahs you should use:

    trash  ~/.config/nvim
    trash ~/.cache/nvim
    trash ~/.local/share/nvim

Clone this repo:

    git clone --depth=1 https://github.com/voyeg3r/nvim.git ~/.config/nvim

Run the following command to install all plugins so its settings will work:

    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

To see all mappings you can use the_silver_searcher

     ag '^map\(' .

Normal mappings are something like:

    map('n' ...)

Insert mappings:

    map('i' ...)

OBS: In my simple-terminal the shortcut Ctrl-alt-c
does not work, in our case it would be used to toggle
the colorizer plugin but you can just run:

Another thing: The "<leader>" key, see ':h leader' is set to ','

    :ColorizerToggle

## Most important mappings we have in the mappings.lua file:

    F2 ..................... toggles NvimTree (NvimTreeToggle)
    F5 ..................... restore last auto saved session (opened files)
    F6 ..................... (native) mapping to jump to the alternate file ':h alternate'
    F9 ..................... save the file (both normal and insert mode)
    Ctrl-p ................. fuzzy file finder with 'telescope'
    Ctrl-d ................. in normal mode scrolls half screen, in insert mode deindent
    Ctrl-u ................. in normal mode scrolls half screen backward
    <leader>v .............. opens $MYVIMRC
    <leader>x .............. :wsh | up | bd!<CR>    (save shada, save if has changes, delete buffer)
    <leader>p .............. select last pasted text
    <leader>d .............. squeeze blank lines (duplicated blank lines become just one)
    <leader>o .............. 'telescope' open recenf files
    <leader>b .............. list and choose opened buffers
    ç ...................... :  (start command mode)
    Ctrl-l ................. toggles highlight search

## Easy motion:

    Each 'j' or 'k' with a count, like 7j or 15k will be added to the jumplist, so you can
    get back to the previous cursor position easily. The mapping responsible for this is:

    map('n', 'j', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], {expr = true})
    map('n', 'k', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], {expr = true})

    Each 'n', 'N', Ctrl-o, Ctrl-i in normal mode also will put the cursor at the vertical middle of the screen

## Easy selection:

    To select the current line just press in normal mode: "vil"
    the mnemonic for this is: "visual inner line"




