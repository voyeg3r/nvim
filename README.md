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

Clone this repo:

    git clone --depth=1 https://github.com/voyeg3r/nvim.git ~/.config/nvim

Run the following command to install all plugins so its settings will work:

    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

To see all mappings you can use the_silver_searcher

     ag '^map\('

Normal mappings are something like:

    map('n')

Insert mappings:

    map('i')

OBS: In my simple-terminal the shortcut Ctrl-alt-c
does not work, in our case it would be used to toggle
the colorizer plugin but you can just run:

    :ColorizerToggle



