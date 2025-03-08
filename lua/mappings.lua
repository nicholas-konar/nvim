require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- remove defaults from ~/.local/share/nvim/lazy/NvChad/lua/nvchad/mappings.lua
vim.keymap.del("n", "<leader>h")
vim.keymap.del("n", "<leader>v")

-- shared id so session persists across orientations
map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "shared" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "shared" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "shared" }
end, { desc = "terminal toggle floating term" })
