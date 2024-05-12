require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>gs", ":Neogit<CR>")

-- Disable mappings
local nomap = vim.keymap.del

nomap("n", "<leader>h")
