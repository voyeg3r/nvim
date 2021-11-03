Modular neovim configuration

      nvim
        ├── ftplugin
        │   ├── bash.vim
        │   ├── css.vim
        │   ├── fzf.vim
        │   ├── help.vim
        │   ├── html.vim
        │   ├── markdown
        │   │   └── folding.vim
        │   ├── python.vim
        │   ├── qf.vim
        │   ├── sh.vim
        │   ├── vim.vim
        │   └── zsh.vim
        ├── init.lua  --> manin config file
        ├── lua
        │   ├── autocmd.lua
        │   ├── mappings.lua
        │   ├── plugins
        │   │   ├── config    --> here some (not all) plugins settings
        │   │   └── init.lua  --> here you set your plugins
        │   ├── settings.lua
        │   └── utils.lua     --> useful functions
        ├── packpath          --> this folder we simlink -> ln -sfvn ~/.config/nvim/packpath ~/.local/share/nvim
        │   ├── lspinstall    --> LSP servers
        │   │   ├── bash
        │   │   ├── lua
        │   │   └── python
        │   ├── rplugin.vim
        │   ├── shada
        │   │   └── main.shada
        │   ├── site
        │   │   └── pack      --> plugin manager (all plugins are installed here)
        │   └── telescope_history
        ├── plugin
        │   └── packer_compiled.lua
        └──── README.md        --> this file

### Instalation
To install just run the install.sh (Read the script to make sure what you are doing)

After cloning the repo you must run:

    :PackerSync

### Read about Language Servers in ordeer to install the servers that will help you coding better:
+ https://raygervais.dev/articles/2021/3/neovim-lsp/
+ https://ka.codes/posts/nvim-lspinstall

    :LspInstall

If by any chance nvim complains about not having packer just run:

    [ ! -f ~/.local/share/nvim/site/pack/packer/start/packer.nvim ] && \
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim

     and run again:

     :PackerSync

### Copy error mesages to the clipboard:

    :let @+=execute('messages')

### To see all mappings you can use the_silver_searcher

     ag '^map\(' .

Normal mappings are something like:

    map('n', 'key', 'command')

Insert mappings:

    map('i' ,'key', 'command')

Where `key` could be any keybinding (shortcut) and `command` could be any vim or lua command.

OBS: In my simple-terminal the shortcut Ctrl-alt-c
does not work, in our case it would be used to toggle
the colorizer plugin but you can just run:

Another thing: The "<leader>" key, see ':h leader' is set to ','

    :ColorizerToggle

### Most important mappings we have in the mappings.lua file:

    F2 ..................... toggles NvimTree (NvimTreeToggle)
    F5 ..................... restore last auto saved session (opened files)
    F6 ..................... (native) mapping to jump to the alternate file ':h alternate'
    F9 ..................... save the file (both normal and insert mode)
    Ctrl-p ................. fuzzy file finder with 'telescope'
    <F8> .................   fuzzy file finder in ~/.config folder
    Ctrl-d ................. in normal mode scrolls half screen, in insert mode deindent
    Ctrl-u ................. in normal mode scrolls half screen backward
    1 Ctrl-g ............... show the current file path (full file name)
    <leader>v .............. opens $MYVIMRC
    <leader>x .............. :wsh | up | bd!<CR>    (save shada, save if has changes, delete buffer)
    <leader>w .............. :bw!   (discards current buffer and keep opened window) read more at -> :h bw
    <leader>p .............. select last pasted text
    <leader>d .............. squeeze blank lines (duplicated blank lines become just one)
    <leader>o .............. 'telescope' open recenf files
    <leader>b .............. list and choose opened buffers
    <leader>gp ............  show last git commits (if we are in a git repo)
    ç ...................... :  (start command mode)
    Ctrl-l ................. toggles highlight search
    Ctrl-[ ................  another easy way to leave insert mode
    gf ....................  another default mapping to open the file under the cursor

### Tips about NvimTree:

When you open the NvimTree with F2, you can press 'g?' to toggle the builtin help for the plugin.

### Easy motion:

Each 'j' or 'k' with a count, like 7j or 15k will be added to the jumplist, so you can
get back to the previous cursor position easily. The mapping responsible for this is:

    map('n', 'j', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']], {expr = true})
    map('n', 'k', [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']], {expr = true})

Each 'n', 'N', Ctrl-o, Ctrl-i in normal mode also will put the cursor at the vertical middle of the screen

### Easy selection:

    To select the current line just press in normal mode: "vil"
    the mnemonic for this is: "visual inner line"

