require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- toggle term with <leader> (swaps defaults from ~/.local/share/nvim/lazy/NvChad/lua/nvchad/mappings.lua)
map("n", "<A-h>", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<A-v", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })

-- shared id so session persists across orientations
map({ "n", "t" }, "<leader>h", function()
  require("nvchad.term").toggle { pos = "sp", id = "shared" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<leader>v", function()
  require("nvchad.term").toggle { pos = "vsp", id = "shared" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<leader>i", function()
  require("nvchad.term").toggle { pos = "float", id = "shared" }
end, { desc = "terminal toggle floating term" })
