-- Filename: filetype.lua
-- Last Change: Wed, 25 Oct 2023 - 05:49

-- [lua file detection feature](https://github.com/neovim/neovim/pull/16600#issuecomment-990409210)

vim.g.do_filetype_lua = 1
--vim.g.did_load_filetypes = 0

vim.filetype.add({
  extension = {
    conf = "conf",
    config = "conf",
    md = "markdown",
    mdx = 'mdx',
    lua = "lua",
    sh = "sh",
    zsh = "sh",
    h = function(path, bufnr)
      if vim.fn.search("\\C^#include <[^>.]\\+>$", "nw") ~= 0 then
        return "cpp"
      end
      return "c"
    end,
  },

  pattern = {
    ["^\\.?(?:zsh(?:rc|env|-aliases)?)$"] = "sh",
  },

  filename = {
    ["TODO"] = "markdown",
    [".git/config"] = "gitconfig",
    -- ["~/.dotfiles/zsh/termux/zsh-aliases"] = "sh",
    -- ["~/.dotfiles/zsh/.zshrc"] = "sh",
    -- ["~/.zshrc"] = "sh",
    -- [ "~/.config/mutt/muttrc"] = "muttrc",
    ["README$"] = function(path, bufnr)
      if string.find("#", vim.api.nvim_buf_get_lines(bufnr, 0, 1, true)) then
        return "markdown"
      end
      -- no return means the filetype won't be set and to try the next method
    end,
  },
})
