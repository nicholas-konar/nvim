return {
	"nvim-mini/mini.clue",
	config = function()
		require("mini.clue").setup({
			window = {
				delay = 0,
				scroll_up = "<C-k>",
				scroll_down = "<C-j>",
				config = function()
					return {
						anchor = "NE",
						row = "auto",
						col = "auto",
						width = "auto",
					}
				end,
			},
			triggers = {
				{ mode = "n", keys = "<leader>" },
				{ mode = "x", keys = "<Leader>" },

				-- Built-in completion
				{ mode = "i", keys = "<C-x>" },

				-- `g` key
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- Marks
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },

				-- Registers
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				-- Window commands
				{ mode = "n", keys = "<C-w>" },

				-- `z` key
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},
		})
	end,
}
