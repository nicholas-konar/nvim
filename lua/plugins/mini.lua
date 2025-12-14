return {
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			require("mini.comment").setup({
				mappings = {
					comment = "<leader>cc",
					comment_line = "<leader>c",
				},
			})
		end,
	},
}
