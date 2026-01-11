return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	init = function()
		require("nvim-treesitter").install({ "typescript", "javascript", "python", "lua" })
	end,
}
