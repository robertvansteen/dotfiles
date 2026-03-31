-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.wrap = false

-- Use intelephense instead of phpactor for PHP LSP
vim.g.lazyvim_php_lsp = "intelephense"
