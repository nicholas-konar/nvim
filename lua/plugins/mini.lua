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
		end,
	},
}
