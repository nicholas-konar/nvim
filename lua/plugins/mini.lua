return {
	{
		"nvim-mini/mini.nvim",
		version = false,
		keys = {
			{
				"<leader>e",
				function()
					require("mini.files").open()
				end,
				desc = "open minifiles",
			},
		},
		config = function()
			-- vim.o.background = "dark"
			-- vim.cmd.colorscheme("minispring")
			require("mini.files").setup()
			require("mini.comment").setup({
				mappings = {
					comment = "<leader>cc",
					comment_line = "<leader>c",
				},
			})
		end,
	},
}
