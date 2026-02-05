return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		init = function()
			require("nvim-treesitter").install({
				"typescript",
				"javascript",
				"prisma",
				"python",
				"lua",
			})
		end,

		config = function()
			require("nvim-treesitter").setup({
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		opts = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
				selection_modes = {
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter-textobjects").setup(opts)
		end,
	},
}
