return {
	"nvim-mini/mini.clue",
	config = function()
		local clue = require("mini.clue")
		clue.setup({
			clues = {
				clue.gen_clues.builtin_completion(),
				clue.gen_clues.g(),
				clue.gen_clues.marks(),
				clue.gen_clues.registers(),
				clue.gen_clues.windows(),
				clue.gen_clues.z(),

				-- teaching hints for mini.ai
				{ mode = "o", keys = "i", desc = "mini.ai: inside textobject" },
				{ mode = "o", keys = "a", desc = "mini.ai: around textobject" },
				{ mode = "x", keys = "i", desc = "mini.ai: select inside textobject" },
				{ mode = "x", keys = "a", desc = "mini.ai: select around textobject" },
			},
			window = {
				delay = 200,
				scroll_up = "<C-k>",
				scroll_down = "<C-j>",
				config = function()
					return {
						anchor = "NE",
						row = "auto",
						col = "auto",
						width = "40",
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

				{ mode = "o", keys = "a" },
				{ mode = "o", keys = "i" },
				{ mode = "x", keys = "a" },
				{ mode = "x", keys = "i" },
			},
		})
	end,
}
