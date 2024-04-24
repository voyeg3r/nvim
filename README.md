# New nvim config

Adding a resource at a time to debug better

# My neovim config

This isn't anything all too special, just your standard config.

## IMPORTANT NOTICES

1. This config is oriented with ***myself*** in mind, so there may possibly be confusing or otherwise strange choices made in the config. Regardless, it works for me. Decide for yourself if I made a janky shitbox of a config, or something actually usable for people other than me.

2. This is a living config, assume nothing is final. Plugins will inevitably change and break. Again, this is a config for myself, not for the masses. Use at your own risk.

3. This config was build around the ***latest*** version of neovim, as I run an Arch-linux based distro. Do not expect this to work without the latest neovim package.

## Also install luacheck

+ [Read guide here](https://github.com/nanotee/nvim-lua-guide#luacheck)

```sh
luarocks install luacheck
luarocks install lanes
```

You can get luacheck to recognize the vim global by putting this configuration in ~/.luacheckrc (or $XDG_CONFIG_HOME/luacheck/.luacheckrc):

``` lua
globals = {
    "vim",
}
```

The Alloyed/lua-lsp language server uses luacheck to provide linting and reads the same file.
For more information on how to configure luacheck, please refer to its documentation

## Installation

I recommend installing nerd fonts: - [Nerd fonts](https://www.nerdfonts.com/font-downloads "Download link")

Then if you have nerd fonts:

```lua
vim.g.have_nerd_font = true -- nerd font
```

The best way to test this is defining an alias that uses the NVIM_APPNAME
environment set

    alias lv='(){(export NVIM_APPNAME=lv;export MYVIMRC=~/.config/lv/init.lua;nvim "$@")}'

then clone:

  git clone https://sergio@bitbucket.org/sergio/mylazy-nvim.git ~/.config/lv

  Those who have the ssh keys:
  git clone git@bitbucket.org:sergio/mylazy-nvim.git ~/.config/nvim

## Set your python virtual environment

```sh
# my neovim config uses a python virtual environment
# The line bellow is in my ~/.zshenv file
[ ! -d ~/.virtualenvs/neovim ] && python -m ~/.virtualenvs/neovim
```

In your options lua:

```lua
-- main editor configs
local function set_globals()
	vim.g.python3_host_prog = vim.loop.os_homedir() .. "/.virtualenvs/neovim/bin/python"
end
```

## todo

+ toggle surround (done)

